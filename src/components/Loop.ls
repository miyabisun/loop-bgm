require! {
  react: {create-element: dom}
  \../actions.ls : {set-is-loop}
}

Loop = ({is-loop, dispatch})->
  dom \span,
    class-name: \loop-button
    style: Loop.style.(if is-loop then \active else \disabled)
    on-click: (e)->
      dispatch set-is-loop (not is-loop)

Loop <<<
  style:
    active:
      background-color: \#dff
    disabled:
      background-color: \#888

module.exports = Loop

