require! {
  \react-redux : {connect}
  \../components/AudioDisplay.ls
  \../actions.ls : {to-time}
}

map-state-to-props = ({file, player, analyzer}:state)->
  d: analyzer.d?
  time: player.time or 0
  current-time: player.current-time or 0
  loop-start: analyzer.loop-start or 0
  loop-end: analyzer.loop-end or player.time or 0

map-dispatch-to-props = (dispatch)->
  to-time: (time)->
    dispatch to-time time

module.exports = connect map-state-to-props, map-dispatch-to-props <| AudioDisplay

