import axios from "axios";
import React, { useState, useEffect } from "react";
import setAxiosHeaders from "../AxiosHeaders";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import { faPen } from '@fortawesome/free-solid-svg-icons'
import { faTrashAlt } from '@fortawesome/free-solid-svg-icons'
import { faTimesCircle } from '@fortawesome/free-solid-svg-icons'

const Categories = () => {

  const [ categories, setCategories ] = useState([]);
  const [ name, setName ] = useState("");
  const [ image, setImage ] = useState("");

  useEffect(() => {
    getCategories()
  },[])

  function getCategories() {
    axios
      .get("/api/v1/categories") 
      .then(response => {
        const fetchedCategories = response.data
        setCategories(fetchedCategories)
      }).catch( error => {
        console.log(error)
      })
  }

  function handleNameChange(e) {
    setName(e.target.value)
  }

  function handleImageChange(e) {
    setImage(e.target.file[0])
  }

  function handleSubmit(e) {
    e.preventDefault()
    setAxiosHeaders()
    
    const formData = new FormData()
    formData.append('category[name]', name)
    formData.append('category[image]', image)

    axios
      .post("/api/v1/categories", parmas)
      .then( response => {
        const category = response.data
        const newCategories = [category, ...categories]
        setCategories(newCategories)
      }).catch( error => {
        console.log(error)
      })
  }


  const listItems = categories.map( (category) => {
    return <CategoriesListItem  key={category.id} category={category} />
  })

  return (
    <div className="dashboard-categories">
      <h1 className="dsashboard-categories__heading">Categories</h1>
      <form className="dashboard-categories__form" onSubmit={handleSubmit}>
        <div className="field">
          <input type="text" name="category[name]" onChange={handleNameChange} placeholder="Name" />
        </div>
        <div className="field">
          <input type="file" name="category[image]" onChange={handleImageChange} />
        </div>
        <button className="submit-btn add-category-btn">Add Category</button>
      </form>
      <ul className="categories-list">
        {listItems}
      </ul>
    </div>
  )
}


const CategoriesListItem = (props) => {

  const { category } = props

  function handleEdit() {

  }

  function handleDelete() {

  }
  
  return (
    <li className="categories-list__item">
      <p className="name">{category.name}</p>
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
             backgroundImage: `url(${category.image_url})`
            }}>
      </div>
    </li>
  )
}

export default Categories;