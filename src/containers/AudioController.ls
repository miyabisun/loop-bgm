require! {
  \prelude-ls : {fix}
  \react-redux : {connect}
  \../components/AudioController.ls
  \../actions.ls : {set-current-time, set-is-playing, set-is-muted, set-volume}
}
Audio = -> document.query-selector \audio or {}
request-frame = window.request-idle-callback or window.request-animation-frame

map-state-to-props = ({file, player}:state)->
  src: file.src or ""
  time: player.time or 0
  is-playing: player.is-playing or not Audio!.paused or no
  is-muted: player.is-muted or Audio!.muted or no
  volume: player.volume or Audio!.volume or 0
  current-time: player.current-time or 0

map-dispatch-to-props = (dispatch)->
  on-play: ->
    do fix (current-time-update, _)-->
      if Audio!.paused => return
      dispatch set-current-time Audio!.current-time
      request-frame current-time-update
  on-pause: -> dispatch set-is-playing no
  toggle-play: ->
    switch Audio!.paused
    | yes => Audio!.play!
    | _ => Audio!.pause!
  toggle-mute: ->
    switch Audio!.muted
    | yes =>
      dispatch set-is-muted no
      Audio!.muted = no
    | _ =>
      dispatch set-is-muted yes
      Audio!.muted = yes
  set-volume: (value)->
    dispatch set-volume value
    Audio!.volume = value

module.exports = connect map-state-to-props, map-dispatch-to-props <| AudioController

