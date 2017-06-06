require! {
  \react-redux : {connect}
  \../components/Wave.ls
}

map-state-to-props = ({file}:state)->
  width: 1000px
  height: 150px
  d: file.d or []

module.exports = connect(map-state-to-props) Wave

