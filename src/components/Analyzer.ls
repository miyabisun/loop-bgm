require! {
  react: {create-element: dom}
  \../containers/AnalyzerWave.ls : Wave
  \../actions.ls : {to-time}
}

Analyzer = ({time, current-time, dispatch, is-loop, loop-start, loop-end})->
  dom \section, class-name: \audio-analyzer,
    dom Wave
    dom \div, class-name: \line_0
    dom \div, class-name: \line_-1
    <[1.00 0.00 -1.00]>.map (val, index)->
      dom \div,
        class-name: \layer-label
        key: val
        style: top: (Analyzer.style.height / 2 - 10px) * index + 3px
        val
    [0 to parse-int(time) by 10].map (now)->
      dom \div,
        class-name: "time-label #{if now % 30 is 0 then \just else \normal}"
        key: now
        style: transform: "translateX(#{now * Analyzer.style.width / time |> parse-int}px)"
        if now % 30 is 0 then dom \label, null, "#{now}sec" else ""
    dom \div,
      class-name: \loop-start
      style:
        width: loop-start * Analyzer.style.width / time |> parse-int |> (or 0)
    dom \div,
      class-name: \loop-end
      style:
        width: (time - loop-end) * Analyzer.style.width / time |> parse-int |> (or 0)
    dom \div, class-name: \current-time, style: transform: "translateX(#{current-time * Analyzer.style.width / time |> parse-int}px)"
    dom \div,
      class-name: \panel
      on-click: ({native-event: e})->
        e.prevent-default!
        x = e.layer-x
        dispatch to-time x / Analyzer.style.width * time

Analyzer <<<
  style:
    width: 1000px
    height: 150px
    padding-bottom: 20px
    padding-left: 30px

module.exports = Analyzer

