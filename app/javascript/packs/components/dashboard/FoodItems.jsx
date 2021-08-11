import axios from "axios"
import setAxiosHeaders from "../AxiosHeaders"
import React, { useEffect, useState } from "react"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faPen } from '@fortawesome/free-solid-svg-icons'
import { faTrashAlt } from '@fortawesome/free-solid-svg-icons'

const FoodItems = () => {

  const [ foodItems, setFoodItems ] = useState([]);
  const [ name, setName] = useState("");
  const [ description, setDescription ] = useState("");
  const [ price, setPrice ] = useState("");
  const [ image, setImage ] = useState("");


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

  function handleImageChange(e) {
    setImage(e.target.files[0])
  }

  function handleSubmit(e) {
    e.preventDefault()
    setAxiosHeaders()
    
    const formData = new FormData();
    formData.append("file", image)

    const params = {
      food_item: {
        name: name,
        description: description,
        price: price,
        image: formData
      }
    }

    axios
      .post("/api/v1/food_items", params)
      .then( response => {
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
    <div className="dashboard-food-items">
      <h1 className="dashboard-food-items__heading">Food Items</h1>
      <form onSubmit={handleSubmit} className="dashboard-food-items__form">
        <div className="field">
          <input type="text" name="food_item[name]" onChange={handleNameChange} placeholder="Name" />
        </div>
        <div className="field">
          <textarea name="food_item[description]" onChange={handleDescriptionChange} placeholder="Description" />
        </div>
        <div className="field">
          <input type="text" name="food_item[price]"onChange={handlePriceChange} placeholder="Price"/>
        </div>
        <div className="field">
          <input type="file" name="food_item[image]" onChange={handleImageChange} />
        </div>
        <div className="actions ">
          <button className="submit-btn add-food-items-btn">Add Food Item</button>
        </div>
      </form>
      <div className="food-items-list">
        <ul>
          {listItems}
        </ul>
      </div>
    </div>
  )
}

const FoodItemsListItem = (props) => {

  const { foodItem } = props

  return (
    <li className="food-items-list__item">
      <p className="name">{foodItem.name}</p>
      <p className="description">{foodItem.description}</p>
      <p className="price">{foodItem.price}</p>
      <div className="actions">
        <button className="edit-btn" onClick={handleEdit}>
          <FontAwesomeIcon icon={faPen} />
        </button>  
        <button className="delete-btn">
          <FontAwesomeIcon icon={faTrashAlt} onClick={handleDelete} />
        </button>
      </div>
      <div className="food-item__image-container"
           style={{
             backgroundImage: `url(${foodItem.image_url})`
            }}>
      </div>
    </li>
  )
}

export default FoodItems;