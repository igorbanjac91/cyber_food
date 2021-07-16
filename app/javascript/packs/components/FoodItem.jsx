import React from "react"
import PropTypes from "prop-types"

const FoodItem = (props) => {

  const { foodItem } = props

  return (
    <li>
      <h3>{foodItem.name}</h3>
      <p>{foodItem.description}</p>
      <span>{foodItem.price}</span>
      <span>{foodItem.image_url}</span>
      <img src={foodItem.image_url} alt={foodItem.name} width="100"/>
    </li>
  )
}

export default FoodItem;

FoodItem.PorpTypes = {
  todoItme: PropTypes.object.isRequired
}