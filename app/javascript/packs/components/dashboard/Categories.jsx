import axios from "axios";
import React, { useState, useEffect } from "react";
import setAxiosHeaders from "../AxiosHeaders";

const Categories = () => {

  const [ categories, setCategories ] = useState([]);
  const [ name, setName ] = useState("");


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

  function handleSubmit(e) {
    e.preventDefault()
    setAxiosHeaders()
    
    const parmas = {
      category:  {
        name: name,
      }
    }

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
    <div>
      <h1>Categories</h1>
      <form onSubmit={handleSubmit}>
        <label>Name
          <input type="text" name="category[name]" onChange={handleNameChange} />
        </label>
        <button className="submit-btn">Add Category</button>
      </form>
      <ul>
        {listItems}
      </ul>
    </div>
  )
}


const CategoriesListItem = (props) => {

  const { category } = props

  return (
    <li>
      <p>Name: {category.name}</p>
    </li>
  )
}

export default Categories;