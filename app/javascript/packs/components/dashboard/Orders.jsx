import axios from "axios";
import React, { useEffect } from "react";

const Orders = () => {

  useEffect(() => {
    getOrders()
  }, [])

  function getOrders() {

    axios
      .get("/api/v1/orders")   
      .then( response => {
        console.log(response.data)
      })

  }

  return (
    <div>
      <h1>Orders</h1>
      <OrdersTable />
    </div>
  )
}



const OrdersTable = () => {
  
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
        < OrderRow />
      </tbody>
    </table>
  )
}


const OrderRow = () => {
  
  return (
    <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td>
        <a href="#"></a>
        <a href="#"></a>
      </td>
    </tr>
  )
}

export default Orders;
