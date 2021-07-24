import React, { useEffect } from "react"
import PropTypes from "prop-types"
import axios from "axios"
import { passCsrfToken } from "../../utility/helper"


const FoodItem = (props) => {
  
  const { foodItem } = props
  
  function handleClick(e) {
    e.preventDefault()
    passCsrfToken(document, axios)

    const order_item = {
      order_item: {
        quantity: 1, 
        food_item_id: foodItem.id
      }
    }

    axios
      .post('api/v1/orders', order_item)
      .then( response => {
        console.log(response.data)
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