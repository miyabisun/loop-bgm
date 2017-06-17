require! {
  react: {create-element: dom}
  \prop-types : PropTypes
  \../actions.ls : {set-is-loop}
}

Loop = ({is-loop, dispatch})->
  dom \span,
    class-name: \loop-candidates
    style: Loop.style.(if is-loop then \active else \disabled)
    on-click: (e)->
      dispatch set-is-loop (not is-loop)

Loop <<<
  style:
    active:
      background-color: \#dff
    disabled:
      background-color: \#888
  prop-types:
    is-loop: PropTypes.func.is-required

module.exports = Loop

