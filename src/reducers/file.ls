require! {
  \prelude-ls : {map, each, at, maximum, minimum, round}
}
url = window.URL or window.webkit-URL

module.exports = (state = {}, action)->
  switch action.type
  | \SET_MUSIC =>
    {} <<< state <<<
      file: action.file
      src: url.create-object-URL action.file
  | \SET_WAVE =>
    d = []
    render-rate = 20ms * 0.001
    {audio-buffer, sample-rate, height} = action
    (data = audio-buffer.get-channel-data 0)
      .for-each (datum, index)->
        unless index % (render-rate * sample-rate) is 0 => return
        if index is 0 => d.push "M0 500"; return
        x = index / (render-rate * sample-rate) |> round
        y = [0ms to 19ms] |> map (/ 1000)
          >> ((*) sample-rate)
          >> ((+) index)
          >> (at _, data)
        [maximum(y), minimum(y)]
        |> map -> (1 - it) / 2 * height
        |> each -> d.push "L#x #it"
    {} <<< state <<< {d, action.audio-buffer}
  | \SET_D =>
    {} <<< state <<< {action.d}
  | _ => state

