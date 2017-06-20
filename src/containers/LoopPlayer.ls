require! {
  \prelude-ls : {maximum}
  \react-redux : {connect}
  \../components/LoopPlayer.ls
  \../actions.ls : {start, stop, search-loop, test}
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
  download: ({analyzer, file})->
    #TODO:create download method
    console.warning \todo:create_download_method

module.exports = connect map-state-to-props, map-dispatch-to-props <| LoopPlayer

