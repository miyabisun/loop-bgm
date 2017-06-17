require! {
  react: {create-element: dom}
  \material-ui : {Paper}
  \../containers/LoopPlayer.ls
  \../containers/LoopStart.ls
  \../containers/LoopEnd.ls
}

Analyzer = ->
  dom Paper, class-name: \analyzer, z-depth: 2,
    dom LoopPlayer
    dom LoopStart
    dom LoopEnd

module.exports = Analyzer

