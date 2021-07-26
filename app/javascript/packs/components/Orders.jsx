import axios from "axios";
import React from "react"
import { useParams } from "react-router";

import Order from "./Order";

const Orders = () => {

  let { id } = useParams()

  function getOrder() {
    axios
      .get(`api/v1/order/${id}`)
      .then(response => console.log(response))
  }

  return (
    <Order  />
  )
}

export default Orders;