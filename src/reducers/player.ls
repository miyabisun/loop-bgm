require! {
  \../actions.ls : {}
}
Audio = -> document.query-selector \audio
request-frame = window.request-idle-callback or window.request-animation-frame
cancel-frame = window.cancel-idle-callback or window.cancel-animation-frame

module.exports = (state = {}, action)->
  switch action.type
  | \SET_TIME => {} <<< state <<< {action.time}
  | \SET_IS_PLAYING => {} <<< state <<< {action.is-playing, current-time: 0}
  | \SET_CURRENT_TIME => {} <<< state <<< {action.current-time}
  | \SET_UPDATE_ID => {} <<< state <<< {action.update-id}
  | \SET_IS_LOOP => {} <<< state <<< {action.is-loop}
  | \SET_LOOP_START => {} <<< state <<< {action.loop-start}
  | \SET_LOOP_END => {} <<< state <<< {action.loop-end}
  | \TO_TIME =>
    Audio!.current-time = action.time
    {} <<< state <<< {current-time: action.time}
  | \LOOP =>
    if state.is-loop and Audio!.current-time > state.loop-end
      Audio!.current-time = Audio!.current-time - (state.loop-end - state.loop-start)
    state
  | \PLAY =>
    {} <<< state <<< {is-playing: yes}
  | \STOP =>
    cancel-frame state.update-id
    {} <<< state <<< {is-playing: no, update-id: null}
  | _ => state

