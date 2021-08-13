import axios from "axios";
import { func } from "prop-types";
import React, { useEffect, useState } from "react";
import setAxiosHeaders from "../AxiosHeaders";

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

  function handleClickComplete(order) {
    setAxiosHeaders()

    const formData = new FormData()
    formData.append('order[status]', "completed")

    axios
      .put(`/api/v1/orders/${order.id}`, formData)
      .then( response => {
        const updatedOrder = response.data
        updateOrders(updatedOrder)
      }).catch( error => {
        console.log(error)
      })
    
    function updateOrders(order) {
      const updatedOrders = orders.map((item) => {
        if (item.id == order.id) {
           return order
        } else {
          return item
        }
      })
      setOrders(updatedOrders)
    }
  }
  
  return (
    <div className="dashboard-orders">
      <h1 className="dashboard-orders__heading">Orders</h1>
      <OrdersTable orders={orders} handleClickComplete={handleClickComplete}/>
    </div>
  )
}



const OrdersTable = (props) => {
  
  const { orders } = props

  function handleClickComplete(order) {
    props.handleClickComplete(order)
  }

  let ordersRows = orders.map( (order) => {
    return <OrderRow key={order.id} order={order} handleClickComplete={handleClickComplete}/>
  })

  return (
    <table className="dashboard-orders__table">
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
  
  const order = props.order;
  const user = order.user;
  let statusClassName = `order-status ${statusClass(order.status)}`;

  function handleClickComplete() {
    props.handleClickComplete(order)
  }

  function statusClass(type) {

    let classes = {
      completed: "order-status--completed",
      ordered: "order-status--ordered"
    }

    return classes[type]
  }

  return (
    <tr>
      <td className="id-cell">
        {order.id}
      </td>
      <td>
        {user.first_name}
      </td>
      <td className="status-cell">
        <span className={statusClassName}>
          {order.status}
        </span>
      </td>
      <td className="action-cell">
        {order.status == "ordered" &&
          <button onClick={handleClickComplete} className="complete-btn">Complete</button> 
        } 
      </td>
    </tr>
  )
}


export default Orders;
