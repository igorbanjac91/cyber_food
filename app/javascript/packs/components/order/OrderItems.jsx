import React from "react"
import Item from "./Item"

const OrderItems = (props) => {
  
  const orderItems = props.orderItems

  let items = orderItems.map( (orderItem) => {
    return <Item key={orderItem.id} orderItem={orderItem} />
  } )

  return (
    <div>
      <table>
        <tbody>
          {items}
        </tbody>
      </table>
    </div>
  )
}

export default OrderItems;