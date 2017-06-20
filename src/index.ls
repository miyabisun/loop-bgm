require! {
  react: {create-element: dom}:React
  \react-dom : {render}
  \react-redux : {Provider}
  redux: {create-store, apply-middleware}
  \redux-thunk : {default: ReduxThunk}
  \./reducers.ls : root-reducer
  \./components/App.ls
}

window <<<
  store: (store = create-store root-reducer, apply-middleware ReduxThunk)
  state:~ -> window.store.get-state!
dom Provider, {store}, dom App
|> render _, document.get-element-by-id \root

