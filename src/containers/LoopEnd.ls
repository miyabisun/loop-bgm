require! {
  \react-redux : {connect}
  \../components/LoopSetting.ls
  \../actions.ls : {set-loop-end: set-loop, set-loop-end-sample: set-loop-sample, to-time}
}

map-state-to-props = ({player, analyzer}:state)->
  name: \loop-end
  loop-time: analyzer.loop-end or player.time or 0
  loop-sample: analyzer.loop-end-sample or analyzer.audio-buffer?.length or 0
  time: player.time or 0
  samples: analyzer.audio-buffer?.length or 0
  current-time: player.current-time or 0
  d: analyzer.d or []

map-dispatch-to-props = (dispatch)->
  on-change-time: (time)->
    dispatch set-loop time
  on-change-sample: (sample)->
    dispatch set-loop-sample sample
  to-time: (time)->
    dispatch to-time time

module.exports = connect map-state-to-props, map-dispatch-to-props <| LoopSetting

