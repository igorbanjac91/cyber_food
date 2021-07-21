import React from "react"
import Home from "./Home"
import Orders from "./Orders"
import { Route, Switch } from 'react-router-dom'

const App = () => {
  return (
    <div>
      <Switch>
        <Route exact path="/" component={Home} />
        <Route exact path="/orders" component={Orders} />
      </Switch>
    </div>
  )
}

export default App;