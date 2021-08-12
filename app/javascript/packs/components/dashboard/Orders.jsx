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
        const fetchedOrders = response.data
        setOrders(fetchedOrders)
      }).catch( error => {
        console.log(error)
      })

  }

  return (
    <div className="dashboard-orders">
      <h1 className="dashboard-orders__heading">Orders</h1>
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

  return (
    <tr>
      <td>
        {order.id}
      </td>
      <td>
        {user.first_name}
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


export default Orders;
