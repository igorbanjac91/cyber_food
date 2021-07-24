import React, { useEffect, useState } from "react"
import axios from "axios";
import MenuCategory from "./MenuCategory";


const Menu = (props) => {

  const [ categories, setCategories ] = useState([])
  const [ errorMessage, setErrorMessage ] = useState(null)

  useEffect(() => {
    getCategories()
  }, [])


  function getCategories() {
    axios
      .get("api/v1/categories")
      .then(response => {
        const fetchedCategories = response.data
        setCategories(fetchedCategories)
      })
      .catch( error => {
        setErrorMessage( { message: "There was a problem loading the categories..."})
      })
  }

  console.log(categories)

  let menuItems = categories.map( category => (
      <MenuCategory key={category.id} category={category} />
    )
  )

  return (
    <div className="menu">
      {menuItems}
    </div>
  )
}

export default Menu;

