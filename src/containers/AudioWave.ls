require! {
  \react-redux : {connect}
  \../components/Wave.ls
}

map-state-to-props = ({analyzer}:state)->
  width: 1000px
  height: 150px
  d: analyzer.d or []

module.exports = connect map-state-to-props <| Wave

