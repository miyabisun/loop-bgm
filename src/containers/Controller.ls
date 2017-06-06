require! {
  \prelude-ls : {fix}
  \react-redux : {connect}
  \../actions.ls : {play, stop, loop: Loop, set-current-time, set-update-id}
  \../components/Controller.ls
}
Audio = -> document.query-selector \audio
url = window.URL or window.webkit-URL
request-frame = window.request-idle-callback or window.request-animation-frame
cancel-frame = window.cancel-idle-callback or window.cancel-animation-frame

map-state-to-props = ({file}:state)->
  src: file.src or ""

map-dispatch-to-props = (dispatch)->
  on-play: ->
    do fix (current-time-update)-> ->
      dispatch Loop!
      dispatch set-current-time Audio!.current-time
      dispatch set-update-id request-frame current-time-update
    dispatch play!
  on-pause: ->
    dispatch stop!

module.exports = connect(map-state-to-props, map-dispatch-to-props) Controller

