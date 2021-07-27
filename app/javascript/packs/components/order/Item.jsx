import React from "react"

const Item = (props) => {

  return (
    <li>
      <p>Name: {props.item.name}</p>
      <p>Qauntity: {props.item.quantity}</p>
      <button>Pay</button>
    </li>
  )
}

export default Item;