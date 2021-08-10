import axios from "axios";
import React, { useEffect, useState } from "react";

const Orders = () => {

  const [ orders, setOrders ] = useState([])

  useEffect(() => {
    getOrders()
  }, [])

  function getOrders() {

    axios
      .get("/api/v1/orders")   
      .then( response => {
        console.log(response.data)
        const fetchedOrders = response.data
        setOrders(fetchedOrders)
      }).catch( error => {
        console.log(error)
      })

  }

  return (
    <div>
      <h1>Orders</h1>
      <OrdersTable orders={orders} />
    </div>
  )
}



const OrdersTable = (props) => {
  
  const { orders } = props

  let ordersRows = orders.map( (order) => {
    return <OrderRow key={order.id} order={order} />
  })

  return (
    <table>
      <thead>
        <tr>
          <th>Id</th>
          <th>User</th>
          <th>Items</th>
          <th>Staus</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {ordersRows}
      </tbody>
    </table>
  )
}


const OrderRow = (props) => {
  
  const order = props.order
  const user = order.user
  const orderItems = props.order.order_items

  return (
    <tr>
      <td>
        {order.id}
      </td>
      <td>
        {user.name}
      </td>
      <td>
        <OrderItemsList orderItems={orderItems}/>
      </td>
      <td>
        {order.status}
      </td>
      <td>
        <a href="#"></a>
        <a href="#"></a>
      </td>
    </tr>
  )
}


const OrderItemsList = (props) => {

  const orderItems = props.orderItems

  const listItems = orderItems.map( (orderItem) => {
    return <OrderItemsListItem key={orderItem.id} orderItem={orderItem} />
  })

  return (
    <ul>
      {listItems}
    </ul>
  )
}

const OrderItemsListItem = (props) => {

  const { orderItem } = props

  return (
    <li>
      <span>{orderItem.quantity} x</span>
      <span>{orderItem.food_item.name}</span>
    </li>
  )
}



export default Orders;
