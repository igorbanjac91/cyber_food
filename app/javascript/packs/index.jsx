import React from 'react'
import ReactDOM from 'react-dom'
import CategoriesNav from './components/CategoriesNav'
import FoodItems from "./components/FoodItems"
import Home from "./components/Home"

document.addEventListener('DOMContentLoaded', () => {
  const index = document.getElementById("food-items")
  ReactDOM.render(
    <>
      <Home />
    </>,
    index,
  )
})

// document.addEventListener('DOMContentLoaded', () => {
//   const index = document.getElementById("food-items")
//   ReactDOM.render(
//     <>
//       <CategoriesNav />
//       <FoodItems />
//     </>,
//     index,
//   )
// })



