import React, { useEffect, useState } from "react"

import axios from "axios";

import CategoriesNavItem from "./CategoriesNavItem";
import ErrorMessages from "./ErrorMessages";

const CategoriesNav = () => {

  const [categories, setCategories] = useState([]);
  const [errorMessage, setErrorMessage] = useState(null);

  useEffect(() => {
    getCategories();
  }, []);

  function getCategories() {
    axios
      .get("/api/v1/categories")
      .then( response => {
        const fetchedCategories = response.data
        setCategories(fetchedCategories);
      })
      .catch( error => {
        setErrorMessage({ message: "There was an error loading the categories..."})
      })
  }

  const categoriesList = categories.map( (category) => 
    <CategoriesNavItem key={category.id} category={category} />
  )

  return (
    <>
    <h3 className="categories-nav__heading">Categories</h3>
    <div className="categories-nav">
      {errorMessage && (<ErrorMessages errorMessage={errorMessage} />)}
      <ul className="categories-nav__list">
        {categoriesList}
      </ul>
    </div>
    </>
  ) 
}

export default CategoriesNav;

