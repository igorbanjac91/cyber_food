import React from "react"

const Item = (props) => {

  const foodItem = props.orderItem.food_item
  const quantity = props.orderItem.quantity

  let subtotal = Number(quantity) * Number(foodItem.price)

  return (
    <tr>
      <td>
        <button>-</button>
        {quantity}
        <button>+</button>
      </td>
      <td>
        {foodItem.name}
      </td>
      <td>
        {subtotal}
      </td>
    </tr>
  )
}

export default Item;