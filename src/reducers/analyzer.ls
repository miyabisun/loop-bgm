require! {
  \prelude-ls : {round, maximum, map, find, filter, sort-with, flatten, obj-to-pairs}
}
Audio = -> document.query-selector \audio
request-frame = window.request-idle-callback or window.request-animation-frame
cancel-frame = window.cancel-idle-callback or window.cancel-animation-frame

module.exports = (state = {}, action)->
  switch action.type
  | \SET_CONTEXT => {} <<< state <<< {action.context}
  | \SET_AUDIO_BUFFER =>
    {} <<< state <<<
      audio-buffer: action.audio-buffer
      loop-start: 0
      loop-start-sample: 0
      loop-end: action.audio-buffer.length / action.audio-buffer.sample-rate * 1000 |> round |> (* 0.001)
      loop-end-sample: action.audio-buffer.length
  | \SET_RENDER_RATE => {} <<< state <<< {action.render-rate}
  | \SET_WAVE =>
    d = []
    {{sample-rate}:audio-buffer, height} = action
    render-rate = (state.render-rate or 20ms) * 0.001 * sample-rate
    (data = audio-buffer.get-channel-data 0)
      .for-each (datum, index)->
        unless index % render-rate is 0 => return
        if index is 0 => d.push "M0 500"; return
        x = index / render-rate |> round
        y = (1 - datum) / 2 * height |> round
        d.push "L#x #y"
    {} <<< state <<< {d}
  | \SET_D => {} <<< state <<< {action.d}
  | \SET_LOOP_START =>
    {} <<< state <<<
      loop-start: action.loop-start
      loop-start-sample: action.loop-start * state.audio-buffer.sample-rate |> round
  | \SET_LOOP_END =>
    {} <<< state <<<
      loop-end: action.loop-end
      loop-end-sample: action.loop-end * state.audio-buffer.sample-rate |> round
  | \SET_LOOP_START_SAMPLE =>
    {} <<< state <<<
      loop-start: action.loop-start-sample / state.audio-buffer.sample-rate * 1000 |> round |> (* 0.001)
      loop-start-sample: action.loop-start-sample
  | \SET_LOOP_END_SAMPLE =>
    {} <<< state <<<
      loop-end: action.loop-end-sample / state.audio-buffer.sample-rate * 1000 |> round |> (* 0.001)
      loop-end-sample: action.loop-end-sample
  | \SET_TEST_TIME => {} <<< state <<< {action.test-time}
  | \SEARCH_LOOP =>
    {{sample-rate}:audio-buffer} = state
    margin = 0.0001
    data = audio-buffer.get-channel-data 0
    candidates-by-sec = [0 to data.length - (sample-rate * 5s) by sample-rate]
    |> map (sample-time)->
      results = []
      start-index = maximum [(round data.length / 2), (sample-time + sample-rate * 5s)]
      for index from start-index to data.length
        if (data.(sample-time) - margin) < data.(index) < (data.(sample-time) + margin)
          results.push index
      return results
    loop-candidates = candidates-by-sec
    |> obj-to-pairs
    |> map ([seconds, candidates])->
      seconds = seconds |> parse-int
      if candidates.length - 5 < seconds => return []
      candidates
      |> map (candidate)->
        priority = [1 to (candidates-by-sec.length - seconds)]
        |> find (after-seconds)->
          a = data.((seconds + after-seconds) * sample-rate)
          b = data.(candidate + after-seconds * sample-rate)
          unless a and b => return yes
          return (a - margin) < b < (a + margin) |> (not)
        |> (or candidates-by-sec.length - seconds)
        return
          loop-start: seconds
          loop-end: candidate / sample-rate * 10000 |> parse-int |> (* 0.0001)
          priority: priority
      |> filter (.priority > 1)
    |> flatten
    |> sort-with (x, y)->
      | x.priority > y.priority => -1
      | x.priority < y.priority => 1
      | _ => 0
    {} <<< state <<< {loop-candidates}
  | \START =>
    state.node.stop 0 if state.node
    (node = state.context.create-buffer-source!)
      ..<<<
        buffer: state.audio-buffer
        loop: yes
        loop-start: state.loop-start
        loop-end: state.loop-end
        playback-rate: {value: 1.0}
        start: node.start or node.note-on
        stop: node.stop or node.note-off
      ..connect state.context.destination
      ..start 0
    {} <<< state <<< {node}
  | \STOP =>
    state.node.stop 0 if state.node
    {} <<< state <<< {node: null}
  | _ => state

