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
    #TODO:create dual-test method
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
  search: -> dispatch search-loop!
  download: ({analyzer, file})->
    #TODO:create download method
    console.warning \todo:create_download_method

module.exports = connect map-state-to-props, map-dispatch-to-props <| LoopPlayer

