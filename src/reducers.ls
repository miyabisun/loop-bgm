require! {
  redux: {combine-reducers}
  \./reducers/file.ls
  \./reducers/player.ls
}

module.exports = combine-reducers {file, player}

