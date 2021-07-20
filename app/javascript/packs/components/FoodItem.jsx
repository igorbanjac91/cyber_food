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
      <div className="food-item__info">
        <h3>{foodItem.name}</h3>
        <p>{foodItem.description}</p>
        <div className="food-item__price-container">
          <span>$ {foodItem.price}</span>
          <button className="btn-add-to-cart">Add To Cart</button>
        </div>
      </div>
    </li>
  )
}

export default FoodItem;

FoodItem.PorpTypes = {
  todoItme: PropTypes.object.isRequired
}