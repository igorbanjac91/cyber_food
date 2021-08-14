import React, { useState, useEffect}  from "react"
import axios from "axios";
import CategoriesNavItem from "./CategoriesNavItem";

const CategoriesNav = (props) => {

  const [ categories, setCategories ] = useState([])

  useEffect(() => {
    getCategories()
  },[])

  function getCategories() {
    axios
      .get("api/v1/categories")
      .then(response => {
        const fetchedCategories = response.data
        setCategories(fetchedCategories)

      })
      .catch( () => {
        setErrorMessage( { message: "There was a problem loading the categories..."})
      })
  }

  function filterByCategory(category) {
    props.filterByCategory(category)
  }

  const categoriesList = categories.map( (category) => 
    <CategoriesNavItem key={category.id} category={category} filterByCategory={filterByCategory}/>
  )
  
  return (
    <div className="categories-nav">
      <h3 className="categories-nav__heading">Categories</h3>
      <ul className="categories-nav__list">
        {categoriesList}
      </ul>
    </div>
  ) 
}

export default CategoriesNav;

