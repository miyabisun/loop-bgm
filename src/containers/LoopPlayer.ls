require! {
  \prelude-ls : {each, map, maximum, Obj}
  \react-redux : {connect}
  \../components/LoopPlayer.ls
  \../actions.ls : {start, stop, search-loop, test}
  \file-saver : {save-as}
  \vorbis-encoder-js : {encoder: Encoder}
}
Audio = -> document.query-selector \audio or {}

map-state-to-props = ({file, analyzer}:state)->
  sound: analyzer.d?
  analyzer: analyzer
  file: file

map-dispatch-to-props = (dispatch)->
  start: -> dispatch start!
  stop: -> dispatch stop!
  test: ({analyzer}:state)->
    (node = analyzer.context.create-buffer-source!)
      ..<<<
        buffer: analyzer.audio-buffer
        loop: yes
        loop-start: analyzer.loop-start
        loop-end: analyzer.loop-end
        playback-rate: {value: 1.0}
        start: node.start or node.note-on
        stop: node.stop or node.note-off
      ..connect analyzer.context.destination
      ..start 0, (maximum [analyzer.loop-end - 1s, 0]), 5s
  dual-test: ({analyzer}:state)->
    unless 1s < analyzer.loop-start < analyzer.loop-end => return
    (left-panner = analyzer.context.create-stereo-panner!)
      ..pan.value = -1
    (left-node = analyzer.context.create-buffer-source!)
      ..<<<
        buffer: analyzer.audio-buffer
        start: left-node.start or left-node.note-on
        stop: left-node.stop or left-node.note-off
      ..playback-rate.value = 0.5
      ..connect left-panner
    (right-panner = analyzer.context.create-stereo-panner!)
      ..pan.value = 1
    (right-node = analyzer.context.create-buffer-source!)
      ..<<<
        buffer: analyzer.audio-buffer
        start: right-node.start or right-node.note-on
        stop: right-node.stop or right-node.note-off
      ..playback-rate.value = 0.5
      ..connect right-panner
    left-panner.connect analyzer.context.destination
    right-panner.connect analyzer.context.destination
    left-node.start 0, (analyzer.loop-start - 1s), 5s
    right-node.start 0, (analyzer.loop-end - 1s), 5s
  search: -> dispatch search-loop!
  download: ({{audio-buffer, loop-start-sample, loop-end-sample}:analyzer, {file: music, metadata}:file})->
    tags = Obj.compact do
      ALBUM: metadata.album
      ARTIST: metadata.artist?.0
      DISCNUMBER: metadata.disk?.of
      TITLE: metadata.title
      TRACKNUMBER: metadata.track?.no
      GENRE: metadata.genre?.0
      DATE: that - /T.*$/ if metadata.year
      LOOPSTART: loop-start-sample
      LOOPLENGTH:  loop-end-sample - loop-start-sample
    encoder = new Encoder audio-buffer.sample-rate, audio-buffer.number-of-channels, 0.4, tags
    encoder.encode-from audio-buffer
    save-as encoder.finish!, (music.name.replace /[^.]*$/, \ogg)
module.exports = connect map-state-to-props, map-dispatch-to-props <| LoopPlayer

