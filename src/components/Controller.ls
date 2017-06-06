require! {
  react: {create-element: dom}
  \prop-types : PropTypes
  \../containers/Loop.ls
}

Controller = ({src, on-play, on-pause})->
  dom \div, class-name: \audio-controller,
    dom \audio,
      controls: yes
      loop: yes
      src: src
      on-play: (e)-> e.prevent-default!; on-play!
      on-pause: (e)-> e.prevent-default!; on-pause!
    dom Loop

Controller <<<
  prop-types:
    src: PropTypes.string.is-required
    on-play: PropTypes.func.is-required
    on-pause: PropTypes.func.is-required

module.exports = Controller

