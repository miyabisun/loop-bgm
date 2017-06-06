require! {
  react: {create-element: dom}
  \prop-types
}

Wave = ({width, height, d})->
  svg-width = d.length / 2 |> parse-int
  dom \svg,
    class-name: \wave
    width: svg-width
    height: Wave.svg.height
    style:
      transform: "scale(#{width / svg-width * 1000 |> parse-int |> (* 0.001)}, #{height / Wave.svg.height * 1000 |> parse-int |> (* 0.001)})"
    dom \path,
      stroke: "rgba(0, 0, 255, 1.0)"
      fill: \none
      stroke-width: \0.5
      stroke-linecap: \round
      stroke-linejoin: \miter
      d: d.join " "

Wave <<<
  svg:
    height: 1000px
  prop-types:
    width: prop-types.number.is-required
    d: prop-types.array-of prop-types.string .is-required

module.exports = Wave

