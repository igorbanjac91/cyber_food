import React, { useEffect, useState } from "react";

import FoodItem from "../FoodItem";
import axios from "axios";
// import ErrorMessages from "..ErrorMessages";

const MenuCategory = (props) => {

  const { category } = props
  const [ foodItems, setFoodItems ] = useState([])

  useEffect(() => {
    getFoodItems(category)
  }, [])

  function getFoodItems(cat) {
    axios
    .get(`api/v1/categories/${cat.id}`)
    .then(response => {
      const fetchedFoodItems = response.data.food_items
      setFoodItems(fetchedFoodItems)
    })
    .catch( error => {
      setErrorMessage({ message: "There was an error loading the categories..."})
    })
  }

  let foodItemsList = foodItems.map( foodItem => (
    < FoodItem key={foodItem.id} foodItem={foodItem} />
  ))

  return (
    <div className="menu__category">
      {/* {errorMessage && (<ErrorMessages errorMessage={errorMessage} />)} */}
      <h3 className="menu__category-heading">{category.name}</h3>
      <ul className="menu__food-item-list">
        {foodItemsList}
      </ul>
    </div>
  )
}

export default MenuCategory;
