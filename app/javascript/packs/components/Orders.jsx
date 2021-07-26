import axios from "axios";
import React, { useEffect } from "react"
import { useParams } from "react-router";

import Order from "./Order";

const Orders = () => {

  let { id } = useParams()

  useEffect(() => {
    getOrder()
  }, [])

  function getOrder() {
    axios
      .get(`api/v1/orders/${id}`)
      .then(response => console.log(response))
  }

  return (
    <Order  />
  )
}

export default Orders;