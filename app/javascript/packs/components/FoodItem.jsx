import React from "react"
import PropTypes from "prop-types"

const FoodItem = (props) => {

  const { foodItem } = props

  return (
    <li>
      <h3>{foodItem.name}</h3>
      <p>{foodItem.description}</p>
      <span>{foodItem.price}</span>
    </li>
  )
}

export default FoodItem;

FoodItem.PorpTypes = {
  todoItme: PropTypes.object.isRequired
}