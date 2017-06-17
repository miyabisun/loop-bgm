require! {
  react: {create-element: dom}
  \material-ui : {MuiThemeProvider}:styles
  \./Audio.ls
  \./Analyzer.ls
}
do require \react-tap-event-plugin

App = ->
  dom MuiThemeProvider, null,
    dom \div, null,
      dom Audio
      dom Analyzer

module.exports = App

