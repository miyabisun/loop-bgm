require! {
  react: {create-element: dom}
  \../containers/LoopStart.ls
  \../containers/LoopEnd.ls
}

LoopSettings = ->
  dom \div,
    class-name: \LoopSettings,
    dom LoopStart
    dom LoopEnd

module.exports = LoopSettings

