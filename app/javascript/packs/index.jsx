import React from 'react'
import ReactDOM from 'react-dom'
import App from './components/App'
// import Home from "./components/Home"
// import Dashboard from './components/dashboard/Dashboard'

import { BrowserRouter as Router, Route } from 'react-router-dom'

document.addEventListener("DOMContentLoaded", () => {
  const index = document.getElementById("pages")
  ReactDOM.render(
    <Router>
      <Route path="/" component={App} />
    </Router>,
    index,
  )
})

// document.addEventListener('DOMContentLoaded', () => {
//   const index = document.getElementById("pages")
//   ReactDOM.render(
//     <>
//       <Dashboard />
//     </>,
//     index,
//   )
// })


