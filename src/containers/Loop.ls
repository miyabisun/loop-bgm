require! {
  \react-redux : {connect}
  \../components/Loop.ls
}

map-state-to-props = ({player}:state)->
  is-loop: player.is-loop

module.exports = connect(map-state-to-props) Loop

