import React, { useEffect, useState } from "react"
import PropTypes, { func } from "prop-types"
import axios from "axios"
import setAxiosHeaders from "../AxiosHeaders"
import FlashMessages from "../shared/FlashMessages"


const FoodItem = (props) => {
  
  const { foodItem } = props
  const [ flashMessages, setFlashMessages ] = useState([])
  const [ disabled, setDisabled ] = useState(false)
  const body = document.querySelector('body')

  function removeMessage() {
    setFlashMessages([]);
  }

  function handleSubmit(e) {
    e.preventDefault()
    setAxiosHeaders()
    setDisabled(true)

    const order_item = {
      order_item: {
        quantity: 1, 
        food_item_id: foodItem.id
      }
    }

    axios
      .post('/api/v1/order_items', order_item)
      .then( response => {
        const orderId = response.data.order_id
        const messages = response.data.flash;
        let cart_link = document.querySelector(".main-header__cart-icon")
        cart_link.setAttribute('href', `/orders/${orderId}`)
        body.style.marginTop = "60px"
        setFlashMessages(messages);
      }).catch( e => {
        console.log(e)
      })
      
  }


  return (
    <li className="food-item">
      <div>
        < FlashMessages  messages={flashMessages} removeMessage={removeMessage} />
      </div>
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
          <form onSubmit={handleSubmit}>
            <button className="btn-add-to-cart" disabled={disabled} >Add To Cart</button>
          </form>
        </div>
      </div>
    </li>
  )
}

export default FoodItem;

FoodItem.PorpTypes = {
  todoItme: PropTypes.object.isRequired
}