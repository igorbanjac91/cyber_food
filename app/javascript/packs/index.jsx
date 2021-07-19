import React from 'react'
import ReactDOM from 'react-dom'
import Categories from './components/categories'
import FoodItems from "./components/FoodItems"

document.addEventListener('DOMContentLoaded', () => {
  const index = document.getElementById("food-items")
  ReactDOM.render(
    <>
      <Categories />
      <FoodItems />
    </>,
    index,
  )
})



