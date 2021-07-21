import React from "react"
import PropTypes from "prop-types"
import axios from "axios"


const FoodItem = (props) => {
  
  const { foodItem } = props
  
  function handleClick(e) {
    e.preventDefault()
    axios
      .post('api/v1/orders', {
        order_item: {
          qunatity: 1, 
          food_item_id: foodItem.id
        }
      })
  }

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
          <button className="btn-add-to-cart" onClick={handleClick}>Add To Cart</button>
        </div>
      </div>
    </li>
  )
}

export default FoodItem;

FoodItem.PorpTypes = {
  todoItme: PropTypes.object.isRequired
}