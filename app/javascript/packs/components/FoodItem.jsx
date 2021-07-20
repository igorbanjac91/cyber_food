import React from "react"
import PropTypes from "prop-types"

const FoodItem = (props) => {

  const { foodItem } = props

  return (
    <li className="food-item">
      <div className="food-item__image-container"
           style={{
             backgroundImage: `url(${foodItem.image_url})`
           }}>
      </div>
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