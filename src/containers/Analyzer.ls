require! {
  \react-redux : {connect}
  \../components/Analyzer.ls
}

map-state-to-props = ({player}:state)->
  time: player.time or 0
  current-time: player.current-time or 0
  is-loop: player.is-loop or 0
  loop-start: player.loop-start or 0
  loop-end: player.loop-end or player.time or 0

module.exports = connect(map-state-to-props) Analyzer

