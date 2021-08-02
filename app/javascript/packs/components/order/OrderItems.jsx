import React from "react"
import Item from "./Item"

const OrderItems = (props) => {
  
  const orderItems = props.orderItems

  let items = orderItems.map( (orderItem) => {
    return <Item key={orderItem.id} orderItem={orderItem} />
  } )

  return (
    <table className="cart-table">
      <tbody className="cart-table__body">
        {items}
      </tbody>
    </table>
  )
}

export default OrderItems;