require! {
  \prelude-ls : {minimum}
  react: {create-element: dom}
  \prop-types : PropTypes
  \material-ui : {GridList, GridTile, Paper, TextField, Divider}
  \./Wave.ls
}

LoopSetting = ({name, loop-time, loop-sample, time, samples, current-time, d, on-change-time, on-change-sample, to-time}:state)->
  dom GridList,
    cell-height: 160px
    cols: 3
    dom GridTile,
      cols: 1
      dom Paper,
        z-depth: 1
        dom TextField,
          floating-label-text: "#{name}-time (sec)"
          type: \number
          step: 0.1
          min: 0
          max: time or 0
          value: loop-time or 0
          on-change: (e)!-> on-change-time minimum [e.target.value |> parse-float |> (or 0), time]
          full-width: yes
          underline-show: no
          disabled: time is 0
        dom Divider
        dom TextField,
          floating-label-text: "#{name}-sample"
          type: \number
          step: 1000
          min: 0
          max: samples or 0
          value: loop-sample or 0
          on-change: (e)!-> on-change-sample minimum [e.target.value |> parse-int, samples]
          full-width: yes
          underline-show: no
          disabled: samples is 0
    dom GridTile,
      cols: 2
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
                to-time (loop-time + e.layer-x / d.length * time)
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
    height: 120px
    padding-bottom: 20px
    padding-left: 30px
  prop-types:
    name: PropTypes.string.is-required
    loop-time: PropTypes.number.is-required
    loop-sample: PropTypes.number.is-required
    time: PropTypes.number.is-required
    samples: PropTypes.number.is-required
    current-time: PropTypes.number.is-required
    d: PropTypes.array.is-required
    on-change-time: PropTypes.func.is-required
    on-change-sample: PropTypes.func.is-required
    to-time: PropTypes.func.is-required

module.exports = LoopSetting

