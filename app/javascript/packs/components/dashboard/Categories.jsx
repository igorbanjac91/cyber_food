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
  const [ categoryId, setCategoryId] = useState("");

  const editPage = document.querySelector(".dashboard-categories__edit")

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
    setImage(e.target.files[0])
  }

  function handleSubmit(e) {
    e.preventDefault()
    setAxiosHeaders()
    
    const formData = new FormData()
    formData.append('category[name]', name)
    formData.append('category[image]', image)

    axios
      .post("/api/v1/categories", formData)
      .then( response => {
        const category = response.data
        const newCategories = [category, ...categories]
        setCategories(newCategories)
      }).catch( error => {
        console.log(error)
      })
  }


  function handleEdit(category) {
    editPage.style.height = "100vh"
    setName(category.name)
    setCategoryId(category.id)
  }

  function handleClose() {
    editPage.style.height = "0"
  }

  function handleUpdate(e) {
    e.preventDefault()
    setAxiosHeaders()

    const formData = new FormData() 
    formData.append("category[name]", name)
    formData.append("category[image]", image)

    axios 
      .put(`/api/v1/categories/${categoryId}`, formData)
      .then( response => {
        const updatedCategory = response.data
        updateCategories(updatedCategory)
        handleClose()
      }).catch( error => {
        console.log(error)
      })

    function updateCategories(category) {
      let newCategories = categories.map( (item) => {
        if ( item.id == category.id ) {
          return category
        } else {
          return item
        }
      })
      setCategories(newCategories)
    }
  }

  function handleDelete(category) {
    setAxiosHeaders()

    axios
      .delete(`/api/v1/categories/${category.id}`)
      .then(() => {
        deleteCategory(category)
      }).catch( error => {
        console.log(error)
      })

      function deleteCategory(category) {
        let newCategories = categories.filter( item => item.id != category.id)
        setCategories(newCategories)
      }
  }

  const listItems = categories.map( (category) => {
    return <CategoriesListItem  key={category.id} 
                                category={category}
                                handleEdit={handleEdit}
                                handleDelete={handleDelete} />
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
      <div className="dashboard-categories__edit">
      <h2 className="dashboard-categories__edit-heading">Edit</h2>
      <button className="times-btn" onClick={handleClose} >
        <FontAwesomeIcon icon={faTimesCircle} />
      </button>
      <form className="dashboard-categories__form edit-form" onSubmit={handleUpdate}>
        <div className="field">
          <input type="text" name="category[name]" onChange={handleNameChange} placeholder="Name" />
        </div>
        <div className="field">
          <input type="file" name="category[image]" onChange={handleImageChange} />
        </div>
        <button className="submit-btn add-category-btn">Edit Category</button>
      </form>
      </div>
    </div>
  )
}


const CategoriesListItem = (props) => {

  const { category } = props

  function handleEdit() {
    props.handleEdit(category)
  }

  function handleDelete() {
    props.handleDelete(category)
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