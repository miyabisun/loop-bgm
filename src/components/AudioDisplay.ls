require! {
  react: {create-element: dom}
  \prop-types : PropTypes
  \../containers/AudioWave.ls : Wave
}

AudioDisplay = ({d, time, current-time, loop-start, loop-end, to-time})->
  dom \section, class-name: "audio-display#{unless d then " disabled" else ""}",
    dom Wave
    dom \div, class-name: \line_0
    dom \div, class-name: \line_-1
    <[1.00 0.00 -1.00]>.map (val, index)->
      dom \div,
        class-name: \layer-label
        key: val
        style: top: (AudioDisplay.style.height / 2 - 10px) * index + 3px
        val
    [0 to parse-int(time) by 10].map (now)->
      dom \div,
        class-name: "time-label #{if now % 30 is 0 then \just else \normal}"
        key: now
        style: transform: "translateX(#{now * AudioDisplay.style.width / time |> parse-int}px)"
        if now % 30 is 0 then dom \label, null, "#{now}sec" else ""
    dom \div,
      class-name: \loop-start
      style:
        width: loop-start * AudioDisplay.style.width / time |> parse-int |> (or 0)
    dom \div,
      class-name: \loop-end
      style:
        width: (time - loop-end) * AudioDisplay.style.width / time |> parse-int |> (or 0)
    dom \div, class-name: \current-time, style: transform: "translateX(#{current-time * AudioDisplay.style.width / time |> parse-int}px)"
    dom \div,
      class-name: \panel
      on-click: ({native-event: e})->
        e.prevent-default!
        to-time e.layer-x / AudioDisplay.style.width * time if d

AudioDisplay <<<
  style:
    width: 1000px
    height: 150px
    padding-bottom: 20px
    padding-left: 30px
  prop-types:
    d: PropTypes.bool.is-required
    time: PropTypes.number.is-required
    current-time: PropTypes.number.is-required
    loop-start: PropTypes.number.is-required
    loop-end: PropTypes.number.is-required
    to-time: PropTypes.func.is-required

module.exports = AudioDisplay

