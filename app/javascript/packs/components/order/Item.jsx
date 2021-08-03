import React from "react"

const Item = (props) => {

  const orderItem = props.orderItem
  const foodItem = props.orderItem.food_item
  const quantity = props.orderItem.quantity

  let subtotal = Number(quantity) * Number(foodItem.price)


  function changeQuantity(e) {
    console.log(e.target.value)
    if (e.target.value == "+") {
      props.changeQuantity(orderItem.id, quantity + 1)
    }
    else {
      props.changeQuantity(orderItem.id, quantity - 1)
    }
  }


  return (
    <tr className="cart-table__row">
      <td className="cart-table__quantity">
        <button className="minus-btn"
                onClick={changeQuantity} value="-">{'\uff0d'}</button>
        <span>{quantity}</span>
        <button className="plus-btn" 
                onClick={changeQuantity} value="+">{'\uff0b'}
        </button>
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