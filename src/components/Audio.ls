require! {
  react: {create-element: dom}
  \material-ui : {Paper}
  \../containers/AudioFile.ls
  \../containers/AudioController.ls
  \../containers/AudioDisplay.ls
}

Audio = ->
  dom Paper, class-name: \audio, z-depth: 2,
    dom AudioFile
    dom AudioController
    dom AudioDisplay

module.exports = Audio

