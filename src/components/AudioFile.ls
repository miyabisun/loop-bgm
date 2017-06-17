require! {
  react: {create-element: dom}
  \prop-types : PropTypes
}

AudioFile = ({on-change})->
  dom \input,
    type: \file
    on-change: (e)->
      e.prevent-default!
      unless (file = e.target.files.0) => return
      on-change file

AudioFile <<<
  prop-types:
    on-change: PropTypes.func.is-required

module.exports = AudioFile

