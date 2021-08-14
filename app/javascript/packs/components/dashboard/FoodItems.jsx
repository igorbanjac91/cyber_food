
import axios from "axios"
import setAxiosHeaders from "../AxiosHeaders"
import React, { useEffect, useState } from "react"
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faPen } from '@fortawesome/free-solid-svg-icons'
import { faTrashAlt } from '@fortawesome/free-solid-svg-icons'
import { faTimesCircle } from '@fortawesome/free-solid-svg-icons'
import { moneyFormat } from "../utils/helpers"

const FoodItems = () => {

  const [ foodItems, setFoodItems ] = useState([]);
  const [ categories, setCategories ] = useState([]);
  const [ name, setName] = useState("");
  const [ description, setDescription ] = useState("");
  const [ price, setPrice ] = useState("");
  const [ image, setImage ] = useState("");
  const [ categoryId, setCategoryId ] = useState("");
  const [ foodItemId, setFoodItemId ] = useState("");

  const editPage = document.querySelector(".dashboard-food-items__edit")

  useEffect(() => {
    getFoodItems();
    getCategories();
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

  function getCategories() {
    axios
      .get("/api/v1/categories")
      .then(response => {
        const fetchedCategories = response.data
        setCategories(fetchedCategories)
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

  function handleCategoryChange(e) {
    setCategoryId(e.target.value)
  }

  function handleSubmit(e) {
    e.preventDefault()
    setAxiosHeaders()
    
    const formData = new FormData();
    formData.append('food_item[image]', image)
    formData.append('food_item[name]', name)
    formData.append('food_item[description]', description)
    formData.append('food_item[price]', price)
    formData.append('food_item[category_id]', categoryId)

    axios
      .post("/api/v1/food_items", formData)
      .then( response => {
        const foodItem = response.data;
        const newFoodItmes = [foodItem, ...foodItems];
        setFoodItems(newFoodItmes)
      }).catch( e => {
        console.log(e)
      })
  }


  function handleEdit(foodItem) {
    editPage.style.height = "100vh"
    setName(foodItem.name)
    setDescription(foodItem.description)
    setPrice(foodItem.price)
    setCategoryId(foodItem.category.id)
    setFoodItemId(foodItem.id)
  }

  function handleClose() {
    editPage.style.height = "0"
  }
    
  function handleUpdate(e) {
    e.preventDefault()
    setAxiosHeaders()
    
    const formData = new FormData();
    formData.append('food_item[image]', image)
    formData.append('food_item[name]', name)
    formData.append('food_item[description]', description)
    formData.append('food_item[price]', price)
    formData.append('food_item[category_id]', categoryId)


    axios
    .put(`/api/v1/food_items/${foodItemId}`, formData)
    .then( response => {
      const updatedFoodItem = response.data
      updateFoodItems(updatedFoodItem)
    }).catch( e => {
      console.log(e)
    })

    function updateFoodItems(foodItem) {
      let newFoodItems = foodItems.map( (item) => {
        if ( item.id == foodItem.id ) {
          return foodItem
        } else {
          return item
        }
      })
      setFoodItems(newFoodItems)
    }
  }



  function handleDelete(foodItem) {
    setAxiosHeaders()

    axios
      .delete(`/api/v1/food_items/${foodItem.id}`)
      .then(response => {
        deleteFoodItem(foodItem)
      }).catch( error => {
        console.log(error)
      })

      function deleteFoodItem(foodItem) {
        let newFoodItems = foodItems.filter( item => item.id != foodItem.id)
        setFoodItems(newFoodItems)
      }
  }

  const listItems = foodItems.map( (foodItem) => {
    return <FoodItemsListItem key={foodItem.id} 
                              foodItem={foodItem} 
                              handleEdit={handleEdit}
                              handleDelete={handleDelete} />
  })

  const listCategoryOptions = categories.map( (category) => {
    return <option key={category.id} value={category.id}>{category.name}</option>
  } )

  return (
    <div className="dashboard-food-items">
      <h1 className="dashboard-food-items__heading">Food Items</h1>
      <form onSubmit={handleSubmit} className="dashboard-food-items__form create-form">
        <div className="field">
          <input type="text" name="food_item[name]" onChange={handleNameChange} placeholder="Name" />
        </div>
        <div className="field">
          <textarea name="food_item[description]" onChange={handleDescriptionChange} placeholder="Description" />
        </div>
        <div className="field">
          <input type="text" name="food_item[price]"onChange={handlePriceChange} placeholder="Price ( in cents )"/>
        </div>
        <div className="field">
          <input type="file" name="food_item[image]" onChange={handleImageChange} />
        </div>
        <div className="field">
          <label htmlFor="category-select">Category:</label>
          <select name="food_item[category]" id="category-select" onChange={handleCategoryChange}>
            {listCategoryOptions}
          </select>
        </div>
        <div className="actions ">
          <button className="submit-btn add-food-items-btn">Add</button>
        </div>
      </form>
      <div className="food-items-list">
        <ul>
          {listItems}
        </ul>
      </div>
      <div className="dashboard-food-items__edit">
        <h2 className="dashboard-food-items__edit-heading">Edit</h2>
        <button className="times-btn" onClick={handleClose} >
          <FontAwesomeIcon icon={faTimesCircle} />
        </button>
        <form onSubmit={handleUpdate} className="dashboard-food-items__form edit-form">
          <div className="field">
            <input type="text" name="food_item[name]" onChange={handleNameChange} placeholder="Name" />
          </div>
          <div className="field">
            <textarea name="food_item[description]" onChange={handleDescriptionChange} placeholder="Description" />
          </div>
          <div className="field">
            <input type="text" name="food_item[price]"onChange={handlePriceChange} placeholder="Price ( in cents )"/>
          </div>
          <div className="field">
            <label htmlFor="category-select">Category:</label>
            <select name="food_item[category]" id="category-select" onChange={handleCategoryChange}>
              {listCategoryOptions}
            </select>
          </div>
          <div className="field">
            <input type="file" name="food_item[image]" onChange={handleImageChange} />
          </div>
          <div className="actions ">
            <button className="submit-btn add-food-items-btn">Edit Food Item</button>
          </div>
        </form>
      </div>
    </div>
  )
}

const FoodItemsListItem = (props) => {

  const { foodItem } = props

  function handleEdit() {
    props.handleEdit(foodItem)
  }

  function handleDelete() {
    props.handleDelete(foodItem)
  }

  return (
    <li className="food-items-list__item">

      <p className="name">{foodItem.name}</p>
      <p className="category">{foodItem.category.name}</p>
      <p className="description">{foodItem.description}</p>
      <p className="price">{moneyFormat(foodItem.price)}</p>
      <div className="actions">
        <button className="edit-btn" onClick={handleEdit} >
          <FontAwesomeIcon icon={faPen} />
        </button>  
        <button className="delete-btn" onClick={handleDelete} >
          <FontAwesomeIcon icon={faTrashAlt} />
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