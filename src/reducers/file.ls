url = window.URL or window.webkit-URL

module.exports = (state = {}, action)->
  switch action.type
  | \SET_MUSIC =>
    url.revoke-object-URL that if state.src
    {} <<< state <<<
      file: action.file
      src: url.create-object-URL action.file
  | \SET_METADATA => {} <<< state <<< {action.metadata}
  | _ => state

