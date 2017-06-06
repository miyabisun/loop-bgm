require! {
  \prelude-ls : {minimum}
  react: {create-element: dom}
  \./Wave.ls
  \../actions.ls : {to-time}
}

LoopSetting = ({name, loop-time, time, current-time, d, on-change, to-time}:state)->
  dom \section, class-name: "loop-setting #name",
    dom \div, null,
      dom \span, null, "#name: "
      dom \input,
        type: \number
        step: \0.1
        min: 0
        value: loop-time or \0
        on-change: (e)!-> [e.target.value |> parse-float |> (or 0), time] |> minimum |> on-change
    dom \div, class-name: \display,
      dom \div, class-name: \line_0
      dom \div, class-name: \line_-1
      <[1.00 0.00 -1.00]>.map (val, index)->
        dom \div,
          class-name: \layer-label
          key: val
          style: top: (LoopSetting.style.height / 2 - 10px) * index + 3px
          val
      dom \div, class-name: \time_0
      dom \div, class-name: \wave-panel,
        dom \div, class-name: \slide, style: transform: "translateX(-#{loop-time / time * d.length}px)",
          dom \div,
            class-name: \panel
            on-click: ({native-event: e})->
              e.prevent-default!
              x = e.layer-x
              to-time (loop-time + x / d.length * time)
            dom Wave, {width: d.length, height: LoopSetting.style.height, d: d}
            [0 to parse-int(time) by 1].map (now)->
              dom \div,
                class-name: "time-label #{if now % 5 is 0 then \just else \normal}"
                key: now
                style:
                  left: now * d.length / time |> parse-int |> (or 0)
                if now % 5 is 0 then dom \label, null, "#{now}sec" else ""
          dom \div, class-name: \current-time, style: transform: "translateX(#{current-time / time * d.length |> parse-int}px)"
      dom \div, class-name: \center-line

LoopSetting <<<
  style:
    width: 500px
    height: 100px
    padding-bottom: 20px
    padding-left: 30px

module.exports = LoopSetting

