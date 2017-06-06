require! {
  \react-redux : {connect}
  \../components/Audio.ls
  \../actions.ls : {set-music, set-wave, set-time}
}
AudioContext = window.AudioContext or window.webkitAudioContext

map-state-to-props = ({file}:state)->
  d: file.d

map-dispatch-to-props = (dispatch)->
  on-change: (file)->
    dispatch set-music file
    (reader = new FileReader!)
      ..onload = ->
        context = new AudioContext
        array-buffer = reader.result
        audio-buffer <~ context.decode-audio-data array-buffer
        dispatch set-wave audio-buffer
        audio-buffer.length / audio-buffer.sample-rate * 1000 |> parse-int |> (* 0.001) |> set-time |> dispatch
      ..read-as-array-buffer file

module.exports = connect(map-state-to-props, map-dispatch-to-props) Audio

