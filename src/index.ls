require! {
  react: {create-element: dom}:React
  \react-dom : {render}
  \react-redux : {Provider}
  redux: {create-store, apply-middleware}
  \redux-thunk : {default: ReduxThunk}
  \./reducers.ls : root-reducer
  \./components/App.ls
}

store = create-store root-reducer, apply-middleware ReduxThunk
window <<< {store}
dom Provider, {store}, dom App
|> render _, document.get-element-by-id \root

