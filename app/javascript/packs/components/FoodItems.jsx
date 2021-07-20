import React, { useEffect, useState } from 'react'

import axios from "axios";

import FoodItem from './FoodItem';
import ErrorMessage from './ErrorMessages';

const FoodItems = () => {

  const [ foodItems, setFoodItems ]  = useState([])
  const [ errorMessage, setErrorMessage] = useState(null)

  useEffect(() => {
    getFoodItems();
  }, [])
  
  // get the categories 
  // for each category fetch food items

  function getFoodItems() {
    axios
      .get("api/v1/food_items")
      .then(response => {
        const fetchedFoodItems = response.data;
        setFoodItems(fetchedFoodItems);
      })
      .catch(error => {
        setErrorMessage({ message: "There was an error laoding you food items..."})
      })
  }

  const listFoodItems = foodItems.map((foodItem) =>
    <FoodItem key={foodItem.id} foodItem={foodItem} />
  )

  return (
    <div className="food-items">
      {errorMessage && (
        <ErrorMessage errorMessage={errorMessage} />
      )}
      <ul className="food-items__list">
        {listFoodItems}
      </ul>
    </div>
  )
}

export default FoodItems