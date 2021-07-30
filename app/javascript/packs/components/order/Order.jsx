import React from "react"
import Item from "./Item"

const Order = (props) => {
  
  const orderItems = props.orderItems

  let items = orderItems.map( (orderItem) => {
    return <Item key={orderItem.id} orderItem={orderItem} />
  } )

  return (
    <div>
      <ul>
        {items}
      </ul>
      <button>Pay</button>
    </div>
  )
}

export default Order;