import React from "react"
import Item from "./Item"

const OrderItems = (props) => {
  
  const orderItems = props.orderItems

  function changeQuantity(id, quantity) {
    console.log(quantity)
    props.changeQuantity(id, quantity)
  }

  let items = orderItems.map( (orderItem) => {
    return <Item key={orderItem.id} 
                 orderItem={orderItem} 
                 changeQuantity={changeQuantity} /> 
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