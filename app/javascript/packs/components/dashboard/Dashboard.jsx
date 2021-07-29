import axios from "axios"
import React, { useEffect, useState } from "react"

const Dashboard = () => {

  const [ toggleFoodItems, setToggleFoodItems] = useState(false)

  function handleFoodItemsClick(e) {
    e.preventDefault()
    setToggleFoodItems(true)
  }

  return (
    <div>
      <nav>
        <ul>
          <li><a onClick={handleFoodItemsClick} >Food Items</a></li>
        </ul>
      </nav>
      { toggleFoodItems && <FoodItemsList /> }
    </div>
  )
}


const FoodItemsList = () => {

  const [foodItems, setFoodItems ] = useState([]);

  useEffect(() => {
    getFoodItems();
  }, [])

  function getFoodItems() {
    axios
      .get("/api/v1/food_items")
      .then(response => {
        const fetchedFoodItems = response.data
        setFoodItems(fetchedFoodItems)
      }).catch( e => {
        console.log(e)
      })
  }

  const listItems = foodItems.map( (foodItem) => {
    return <FoodItemsListItem key={foodItem.id} foodItem={foodItem} />
  })

  return (
    <ul>
      {listItems}
    </ul>
  )
}

const FoodItemsListItem = (props) => {

  const { foodItem } = props

  return (
    <li>
      <p>Name: {foodItem.name}</p>
    </li>
  )
}

export default Dashboard; 