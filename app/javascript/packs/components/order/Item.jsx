import React from "react"

const Item = (props) => {

  const foodItem = props.orderItem.food_item

  return (
    <li>
      <p>Name: {foodItem.name}</p>
      <p>Qauntity: {props.orderItem.quantity}</p>
    </li>
  )
}

export default Item;