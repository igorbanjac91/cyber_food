import React, { useEffect, useState } from "react"
import { useParams } from "react-router";
import axios from "axios";

import OrderItems from "./OrderItems";

const Order = () => {

  let { id } = useParams();
  const [ order, setOrder ] = useState([]);
  const [ orderItems, setOrderItems ] = useState([]);

  useEffect(() => {
    getOrder()
  }, [])

  function getOrder() {
    axios
      .get(`/api/v1/orders/${id}`)
      .then( (response) => {
        const fetchedOrder = response.data
        setOrder(fetchedOrder)
        setOrderItems(fetchedOrder.order_items)
      })   
  }

  return (
    <div className="cart">
      <h2 className="cart__heading" >Cart</h2>
      <OrderItems order={order} orderItems={orderItems} />
      <div className="cart__total-container">
        <span>Total</span>
        <span>$ 32</span>
      </div>
      <button className="checkout-btn">Checkout</button>
      <a href="#">Back To Menu</a>
    </div>
  )
}

export default Order;