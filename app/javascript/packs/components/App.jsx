import React from "react"
import Home from "./home/Home"
import Order from "./order/Order"
import Dashboard from "./dashboard/Dashboard"
import { Route, Switch } from 'react-router-dom'

const App = () => {
  return (
    <div>
      <Switch>
        <Route exact path="/" component={Home} />
        {/* <Route exact path="/orders" component={Orders} /> */}
        <Route exact path="/orders/:id" component={Order} />
        <Route exact path="/dashboard" component={Dashboard} />
      </Switch>
    </div>
  )
}

export default App;