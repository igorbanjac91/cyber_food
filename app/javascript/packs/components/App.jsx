import React from "react"
import Home from "./home/Home"
import Order from "./order/Order"
import { Route, Switch } from 'react-router-dom'
import Orders from "./dashboard/Orders"
import FoodItems from "./dashboard/FoodItems"
import Categories from "./dashboard/Categories"
import UserOrders from "./user/UserOrder"

const App = () => {
  return (
    <div>
      <Switch>
        <Route exact path="/" component={Home} />
        <Route exact path="/orders/:id" component={Order} />
        <Route exact path="/dashboard/orders" component={Orders} />
        <Route exact path="/dashboard/food-items" component={FoodItems} />
        <Route exact path="/dashboard/categories" component={Categories} />
        <Route exact path="/users/orders" component={UserOrders} />
      </Switch>
    </div>
  )
}

export default App;