require! {
  express, pug, fs, livescript, browserify, lsify, stylus
}

app = express!
  ..listen 3000
  ..use \/img, express.static "#__dirname/../assets/images"
  ..get \/js/*, (req, res)->
    res.set \Content-Type, \text/javascript
    req.path
    |> (- /^\/js/)
    |> (.replace /\.js/, \.ls)
    |> -> "#__dirname/../assets/scripts#it"
    |> browserify _, do
      extensions: <[js ls]>
      debug: yes
    |> (.transform lsify, header: yes, const: no)
    |> (.bundle!)
    |> (.pipe res)
  ..get \/css/*, (req, res)->
    res.set \Content-Type, \text/css
    file-path = req.path
    |> (- /^\/css/)
    |> (.replace /\.css/, \.styl)
    |> -> "#__dirname/../assets/stylesheets#it"
    file-path
    |> fs.read-file-sync _
    |> (.to-string!)
    |> stylus _
    |> (.render (err, css)->
      if err
        console.error "#{err.name}: #file-path"
        console.error err.message
      res.send css
    )
  ..get "*/(*.html)?", (req, res)->
    switch
      | req.path is /\/$/ =>
        "#__dirname/../assets/templates#{req.path}index.html"
      | _ =>
        "#__dirname/../assets/templates#{req.path}"
    |> (.replace /\.html/, \.pug)
    |> pug.compile-file _
    |> (do)
    |> res.send _

console.info "Get Ready."

