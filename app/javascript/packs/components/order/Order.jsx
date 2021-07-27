import React from "react"
import Item from "./Item"

const Order = (props) => {
  
  const orderItems = props.orderItems

  let items = orderItems.map( (item) => {
    return <Item key={item.id} item={item} />
  } )

  return (
    <div>
      <ul>
        {items}
      </ul>
    </div>
  )
}

export default Order;