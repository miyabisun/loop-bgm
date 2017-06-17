require! {
  redux: {combine-reducers}
  \./reducers/analyzer.ls
  \./reducers/file.ls
  \./reducers/player.ls
}

module.exports = combine-reducers {file, player, analyzer}

