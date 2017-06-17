require! {
  react: {create-element: dom}
  \prop-types : PropTypes
  \material-ui : {IconButton, Toolbar, ToolbarGroup, ToolbarSeparator, ToolbarTitle}
}

LoopPlayer = ({sound, start, stop, search, test, dual-test, download}:state)->
  dom Toolbar, class-name: \loop-player,
    dom ToolbarGroup, first-child: yes,
      dom IconButton,
        icon-class-name: \material-icons
        tooltip: "search"
        tooltip-position: \bottom-center
        disabled: not sound
        onTouchTap: -> search!
        \search
      dom IconButton,
        icon-class-name: \material-icons
        tooltip: "dual play test"
        tooltip-position: \bottom-center
        disabled: not sound or yes
        onTouchTap: -> dual-test state
        \call_merge
      dom IconButton,
        icon-class-name: \material-icons
        tooltip: "loop test (-1s to +4s)"
        tooltip-position: \bottom-center
        disabled: not sound
        onTouchTap: -> test state
        \hearing
      dom ToolbarSeparator, null
      dom IconButton,
        icon-class-name: \material-icons
        tooltip: "normal play"
        tooltip-position: \bottom-center
        disabled: not sound
        onTouchTap: -> start!
        \play_arrow
      dom IconButton,
        icon-class-name: \material-icons
        tooltip: "stop"
        tooltip-position: \bottom-center
        disabled: not sound
        onTouchTap: -> stop!
        \stop
    dom ToolbarGroup, last-child: yes,
      dom ToolbarTitle, text: \Ogg
      dom IconButton,
        icon-class-name: \material-icons
        tooltip: "download Ogg file"
        tooltip-position: \bottom-center
        disabled: not sound or yes
        onTouchTap: -> download state
        \file_download

LoopPlayer <<<
  prop-types:
    sound: PropTypes.bool.is-required
    analyzer: PropTypes.object.is-required
    file: PropTypes.object.is-required
    start: PropTypes.func.is-required
    stop: PropTypes.func.is-required
    test: PropTypes.func.is-required
    download: PropTypes.func.is-required

module.exports = LoopPlayer

