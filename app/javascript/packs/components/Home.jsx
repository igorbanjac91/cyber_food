import React, { useEffect, useState } from 'react';
import axios from 'axios';

import CategoriesNav from './CategoriesNav';
// import ErrorMessage from '../ErrorMessages';
import Menu from './menu/Menu';

const Home = () => {

  const [ categories, setCategories ] = useState([])
  const [ errorMessage, setErrorMessage] = useState(null)

  useEffect(() => {
    getCategories();
  }, []);

  function getCategories() {
    axios
      .get("api/v1/categories")
      .then(response => {
        const fetchedCategories = response.data
        setCategories(fetchedCategories)
      })
      .catch( error => {
        setErrorMessage( { message: "There was an error loading the categories..."})
      })
  }

  

  return (
    <div className="home">
      {/* {errorMessage && (
        <ErrorMessage errorMessage={errorMessage} />
      )} */}
      <CategoriesNav />
      {/* <Menu categories={categories} /> */}
    </div>
  )
}

export default Home;