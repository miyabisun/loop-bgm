require! {
  \prelude-ls : {round}
  \react-redux : {connect}
  \../components/AudioFile.ls
  \../actions.ls : {set-context, set-audio-buffer, set-music, set-render-rate, set-wave, set-time, set-metadata}
}
AudioContext = window.AudioContext or window.webkitAudioContext

map-dispatch-to-props = (dispatch)->
  on-change: (file)->
    dispatch set-music file
    (reader = new FileReader!)
      ..onload = ->
        context = new AudioContext
        array-buffer = reader.result
        err, metadata <- musicmetadata array-buffer
        audio-buffer <- context.decode-audio-data array-buffer
        dispatch set-metadata metadata
        dispatch set-context context
        dispatch set-audio-buffer audio-buffer
        dispatch set-render-rate 20ms
        dispatch set-wave audio-buffer
        dispatch <| set-time <| audio-buffer.length / audio-buffer.sample-rate * 1000 |> round |> (* 0.001)
      ..read-as-array-buffer file

module.exports = connect null, map-dispatch-to-props <| AudioFile

