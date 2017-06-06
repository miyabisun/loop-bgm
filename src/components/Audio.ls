require! {
  react: {create-element: dom}
  \../containers/Controller.ls
  \../containers/Analyzer.ls
  \./LoopSettings.ls
}

Audio = ({d, dispatch, on-change})->
  dom \div, null,
    dom \input,
      type: \file
      on-change: (e)->
        e.prevent-default!
        unless (file = e.target.files.0) => return
        on-change file
    dom Controller
    dom Analyzer if d
    dom LoopSettings if d

module.exports = Audio

