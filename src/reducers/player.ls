Audio = -> document.query-selector \audio
request-frame = window.request-idle-callback or window.request-animation-frame
cancel-frame = window.cancel-idle-callback or window.cancel-animation-frame

module.exports = (state = {}, action)->
  switch action.type
  | \SET_TIME => {} <<< state <<< {action.time}
  | \SET_CURRENT_TIME => {} <<< state <<< {action.current-time}
  | \SET_IS_PLAYING => {} <<< state <<< {action.is-playing}
  | \SET_IS_MUTED => {} <<< state <<< {action.is-muted}
  | \SET_VOLUME => {} <<< state <<< {action.volume}
  | \TO_TIME =>
    Audio!.current-time = action.time
    {} <<< state <<< {current-time: action.time}
  | _ => state

