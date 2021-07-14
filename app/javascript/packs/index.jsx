import React from 'react'
import ReactDOM from 'react-dom'
import FoodItems from "./components/FoodItems"

document.addEventListener('DOMContentLoaded', () => {
  const index = document.getElementById("food-items")
  ReactDOM.render(
    <FoodItems />,
    index,
  )
})
