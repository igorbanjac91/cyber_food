import React, { useEffect, useState } from "react"

import axios from "axios";

import Category from "./category";
import ErrorMessages from "./ErrorMessages";

const Categories = () => {

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
    <Category key={category.id} category={category} />
  )

  return (
    <>
      {errorMessage && (<ErrorMessages errorMessage={errorMessage} />)}
      <ul>
        {categoriesList}
      </ul>
    </>
  ) 
}

export default Categories;

