import axios from "axios";
import React, { useEffect, useState } from "react";
import Moment from "moment";
import { moneyFormat } from "../utils/helpers";

const UserOrders = () => {

  const [ orders, setOrders ] = useState([])

  useEffect(() => {
    getOrders()
  },[])

  function getOrders() {
    axios
      .get("/api/v1/orders")
      .then( response => {
        console.log(response.data)
        const fetchedOrders = response.data
        setOrders(fetchedOrders)
      })
  }

  return (
    <div className="user-orders">
        <h1 className="user-orders__heading">Orders</h1>
        <OrdersTable orders={orders} />
    </div>
  )
}


const OrdersTable = (props) => {

  let { orders } = props

  const tableRows = orders.map((order) => {
    return <OrdersTableRow key={order.id} order={order} />
  })

  return (
    <table className="user-orders__table">
      <thead>
        <tr>
          <th>Id</th>
          <th>Date</th>
          <th>Items</th>
          <th>Total</th>
        </tr>
      </thead>
      <tbody>
        {tableRows}
      </tbody>
    </table>
  )
}

const OrdersTableRow = (props) => {

  let order = props.order
  let orderItems = order.order_items

  const orderItemsList = orderItems.map( (item) => {
    return <li key={item.id}>{item.quantity} x {item.food_item.name}</li>
  })

  const totalAmount = orderItems.reduce((acc, item) => {
    return acc + (Number(item.quantity) * Number(item.food_item.price))
  }, 0)

  return (
    <tr>
      <td>
        {order.id}
      </td>
      <td>
        {Moment(order.created_at).format("DD/MM/YYYY")}
      </td>
      <td>
        <ul>
          {orderItemsList}
        </ul>
      </td>
      <td>
        {moneyFormat(totalAmount)}
      </td>
    </tr>
  )
}

export default UserOrders;