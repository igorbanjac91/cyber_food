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

  const listFoodItems = foodItems.map((item) =>
    <FoodItem key={item.id}
              foodItem={item}
    />
  )

  return (
    <>
      {errorMessage && (
        <ErrorMessage errorMessage={errorMessage} />
      )}
      <ul>
        {listFoodItems}
      </ul>
    </>
  )
}

export default FoodItems