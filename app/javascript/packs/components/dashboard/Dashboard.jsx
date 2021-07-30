import axios from "axios"
import React, { useEffect, useState } from "react"
import setAxiosHeaders from "../AxiosHeaders"

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
          <li><a onClick={handleFoodItemsClick} className="food-items-link" >Food Items</a></li>
        </ul>
      </nav>
      { toggleFoodItems && <FoodItemsList /> }
    </div>
  )
}


const FoodItemsList = () => {

  const [ foodItems, setFoodItems ] = useState([]);
  const [ name, setName] = useState("");
  const [ description, setDescription ] = useState("");
  const [ price, setPrice ] = useState("");


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

  function handleNameChange(e) {
    setName(e.target.value)
  }

  function handleDescriptionChange(e) {
    setDescription(e.target.value)
  }

  function handlePriceChange(e) {
    setPrice(e.target.value)
  }

  function handleSubmit(e) {
    e.preventDefault()
    setAxiosHeaders()
    
    const params = {
      food_item: {
        name: name,
        description: description,
        price: price
      }
    }

    axios
      .post("/api/v1/food_items", params)
      .then( response => {
        console.log(response.data)
        const foodItem = response.data;
        const newFoodItmes = [foodItem, ...foodItems];
        setFoodItems(newFoodItmes)
      }).catch( e => {
        console.log(e)
      })

  }

  const listItems = foodItems.map( (foodItem) => {
    return <FoodItemsListItem key={foodItem.id} foodItem={foodItem} />
  })

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <label>Name
          <input type="text" name="food_item[name]" onChange={handleNameChange} />
        </label>
        <label>Description
          <input type="text" name="food_item[description]" onChange={handleDescriptionChange}/>
        </label>
        <label>Price
          <input type="text" name="food_item[price]"onChange={handlePriceChange}/>
        </label>
        <button className="submit-btn">Add Food Item</button>
      </form>
      <ul>
        {listItems}
      </ul>
    </div>
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