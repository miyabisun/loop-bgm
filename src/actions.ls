module.exports =
  # action creators
  set-music: (file)-> {type: \SET_MUSIC, file}
  set-wave: (audio-buffer)->
    type: \SET_WAVE
    audio-buffer: audio-buffer
    height: 1000px
    sample-rate: audio-buffer.sample-rate
  set-time: (time)-> {type: \SET_TIME, time}
  set-current-time: (current-time)-> {type: \SET_CURRENT_TIME, current-time}
  set-update-id: (update-id)-> {type: \SET_UPDATE_ID, update-id}
  set-is-loop: (is-loop)-> {type: \SET_IS_LOOP, is-loop}
  set-loop-start: (loop-start)-> {type: \SET_LOOP_START, loop-start}
  set-loop-end: (loop-end)-> {type: \SET_LOOP_END, loop-end}
  to-time: (time)-> {type: \TO_TIME, time}
  loop: -> type: \LOOP
  play: (id)-> type: \PLAY
  stop: (id)-> type: \STOP

