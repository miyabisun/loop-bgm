module.exports =
  # action creators: file
  set-music: (file)-> {type: \SET_MUSIC, file}
  set-metadata: (metadata)-> {type: \SET_METADATA, metadata}

  # action creators: player
  set-time: (time)-> {type: \SET_TIME, time}
  set-current-time: (current-time)-> {type: \SET_CURRENT_TIME, current-time}
  set-is-playing: (is-playing)-> {type: \SET_IS_PLAYING, is-playing}
  set-is-muted: (is-muted)-> {type: \SET_IS_MUTED, is-muted}
  set-volume: (volume)-> {type: \SET_VOLUME, volume}
  to-time: (time)-> {type: \TO_TIME, time}

  # action creators: analyzer
  set-context: (context)-> {type: \SET_CONTEXT, context}
  set-audio-buffer: (audio-buffer)-> {type: \SET_AUDIO_BUFFER, audio-buffer}
  set-render-rate: (render-rate)-> {type: \SET_RENDER_RATE, render-rate}
  set-wave: (audio-buffer)-> {type: \SET_WAVE, audio-buffer, height: 1000px}
  set-d: (d)-> {type: \SET_D, d}
  set-loop-start: (loop-start)-> {type: \SET_LOOP_START, loop-start}
  set-loop-end: (loop-end)-> {type: \SET_LOOP_END, loop-end}
  set-loop-start-sample: (loop-start-sample)-> {type: \SET_LOOP_START_SAMPLE, loop-start-sample}
  set-loop-end-sample: (loop-end-sample)-> {type: \SET_LOOP_END_SAMPLE, loop-end-sample}
  set-test-time: (test-time)-> {type: \SET_TEST_TIME, test-time}
  search-loop: -> type: \SEARCH_LOOP
  start: -> type: \START
  stop: -> type: \STOP

