import React, { useEffect, useState } from "react"
import { useParams } from "react-router";
import axios from "axios";

import Order from "./Order";

const Orders = () => {

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
    <Order  order={order} orderItems={orderItems} />
  )
}

export default Orders;