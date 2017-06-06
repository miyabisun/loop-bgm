require! {
  pug, fs, livescript, browserify, lsify, stylus, del, copy, \readdir-recursive, async
  \prelude-ls : {Obj, each, map, keys}
}

tasks =
  delete: (done)->
    console.info "delete!"
    del.sync "#__dirname/../docs/**"
    fs.mkdir-sync "#__dirname/../docs"
    done?!
  scripts: (done)->
    console.info "scripts!"
    fs.mkdir-sync "#__dirname/../docs/js"
    readdir-recursive.file-sync "#__dirname/../assets/scripts/"
    |> map (subject-path, cb)-->
      file = fs.create-write-stream "#__dirname/../docs/js#{subject-path - /.*assets\/scripts/ |> (.replace /\.ls$/, \.js)}"
        .on \close, cb
      subject-path
      |> -> console.info it; it
      |> browserify _, extensions: <[js ls]>
      |> (.transform lsify, header: yes, const: no)
      |> (.bundle!)
      |> (.pipe file)
    |> async.series _, done
  templates: (done)->
    console.info "templates!"
    readdir-recursive.file-sync "#__dirname/../assets/templates/"
    |> map (subject-path, cb)-->
      dist = "#__dirname/../docs#{subject-path - /.*assets\/templates/ |> (.replace /\.pug$/, \.html)}"
      subject-path
      |> -> console.info it; it
      |> pug.compile-file _
      |> (do)
      |> fs.write-file-sync dist, _
      cb!
    |> async.series _, done
  stylesheets: (done)->
    console.info "stylesheets!"
    fs.mkdir-sync "#__dirname/../docs/css"
    readdir-recursive.file-sync "#__dirname/../assets/stylesheets/"
    |> map (subject-path, cb)-->
      dist = "#__dirname/../docs/css#{subject-path - /.*assets\/stylesheets/ |> (.replace /\.styl/, \.css)}"
      subject-path
      |> -> console.info it; it
      |> fs.read-file-sync _
      |> (.to-string!)
      |> stylus _
      |> (.render (err, css)->
        fs.write-file-sync dist, css
        cb!
      )
    |> async.series _, done
  images: (done)->
    console.info "images!"
    fs.mkdir-sync "#__dirname/../docs/img"
    err, files <- copy "#__dirname/../assets/images/*", "#__dirname/../docs/img"
    files |> each (.dest) >> console.info
    done!
|> Obj.values
|> map (fn, done)--> fn done
|> async.series _, (err)->
  console.info \finish
  console.err that if err

