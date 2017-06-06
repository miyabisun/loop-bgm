require! {
  \react-redux : {connect}
  \../components/LoopSetting.ls
  \../actions.ls : {set-loop-end: set-loop, to-time}
}

map-state-to-props = ({file, player}:state)->
  name: \LoopEnd
  loop-time: player.loop-end or player.time
  current-time: player.current-time or 0
  time: player.time or 0
  d: file.d or []

map-dispatch-to-props = (dispatch)->
  on-change: (time)->
    dispatch set-loop time
  to-time: (time)->
    dispatch to-time time

module.exports = connect(map-state-to-props, map-dispatch-to-props) LoopSetting

