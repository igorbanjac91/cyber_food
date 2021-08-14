import React, { useEffect, useState } from 'react';
import axios from 'axios';
import CategoriesNav from './CategoriesNav';
import Menu from './Menu';

const Home = () => {

  const [ categories, setCategories ] = useState([])

  useEffect(() => {
    getCategories()
  },[])

  function getCategories(category) {
    axios
      .get("api/v1/categories")
      .then(response => {
        const fetchedCategories = response.data
        if (category) {
          const newCategories = fetchedCategories.filter( item => item.id == category.id )
          setCategories(newCategories);
        }
        else {
          setCategories(fetchedCategories)
        }
      })
      .catch( () => {
        setErrorMessage( { message: "There was a problem loading the categories..."})
      })
  }

  function filterByCategory(category) {
    category.name == "all" ? getCategories() : getCategories(category)
  }

  return (
    <div className="home">
      <CategoriesNav filterByCategory={filterByCategory} />
      <Menu categories={categories} />
    </div>
  )
}

export default Home;