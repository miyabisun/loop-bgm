require! {
  express, pug, fs, livescript, browserify, lsify, stylus
}

app = express!
  ..listen 3000
  ..use express.static "#__dirname/../docs"

console.info "Get Ready."

