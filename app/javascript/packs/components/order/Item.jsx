import React from "react"

const Item = (props) => {

  const foodItem = props.orderItem.food_item
  const quantity = props.orderItem.quantity

  let subtotal = Number(quantity) * Number(foodItem.price)

  return (
    <tr className="cart-table__row">
      <td className="cart-table__quantity">
        <button>{'\uff0d'}</button>
        <span>{quantity}</span>
        <button>{'\uff0b'}</button>
      </td>
      <td className="cart-table__food-item-name">
        {foodItem.name}
      </td>
      <td className="cart-table__subtotal">
        $ {subtotal}
      </td>
    </tr>
  )
}

export default Item;