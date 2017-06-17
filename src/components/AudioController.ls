require! {
  react: {create-element: dom}
  \prop-types : PropTypes
  \material-ui : {IconButton, TextField, Slider, Toolbar, ToolbarGroup, ToolbarSeparator, ToolbarTitle}
}
Audio = -> document.query-selector \audio

AudioController = ({src, is-playing, is-muted, volume, current-time, time, on-play, on-pause, toggle-play, toggle-mute, set-volume})->
  dom \section, class-name: \audio-controller,
    dom \audio,
      src: src or ""
      loop: yes
      controls: no
      on-play: -> on-play!
      on-pause: -> on-pause!
    dom Toolbar, null,
      dom ToolbarGroup, first-child: yes,
        dom IconButton,
          icon-class-name: \material-icons
          disabled: not src
          onTouchTap: (e)->
            e.prevent-default!
            toggle-play!
          if is-playing then \play_arrow else \pause
        dom ToolbarSeparator, null
        dom ToolbarTitle,
          style:
            padding-right: 0px
            padding-left: 20px
            font-size: 16px
          text: "#{current-time |> parse-int |> (.to-string!) |> ((+) (parse-int time).to-string!.replace /./g, \0) |> (.slice (0 - (parse-int time).to-string!.length))}s / #{time |> parse-int}s"
        dom ToolbarSeparator, null
        dom IconButton,
          icon-class-name: \material-icons
          disabled: not src
          onTouchTap: (e)->
            e.prevent-default!
            toggle-mute!
          if is-muted then \volume_off else \volume_up
        dom Slider,
          name: \volume
          disabled: not src
          min: 0
          max: 1
          step: 0.05
          value: volume
          style: width: 200px, height: 67px
          on-change: (e, value)->
            e.prevent-default!
            set-volume value
      dom ToolbarGroup, last-child: yes,
        dom TextField,
          class-name: \current-time
          value: current-time
          disabled: yes
          floating-label-text: "current-time (sec)"
          underline-show: no

AudioController <<<
  prop-types:
    src: PropTypes.string.is-required
    is-playing: PropTypes.bool.is-required
    is-muted: PropTypes.bool.is-required
    volume: PropTypes.number.is-required
    current-time: PropTypes.number.is-required
    time: PropTypes.number.is-required
    on-play: PropTypes.func.is-required
    on-pause: PropTypes.func.is-required
    toggle-play: PropTypes.func.is-required
    toggle-mute: PropTypes.func.is-required
    set-volume: PropTypes.func.is-required

module.exports = AudioController

