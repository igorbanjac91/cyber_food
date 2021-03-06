import React from "react"
import MenuCategory from "./MenuCategory";


const Menu = (props) => {

  let { categories } = props

  let menuItems = categories.map( category => {
    if ( category.name != "all") {
      return <MenuCategory key={category.id} category={category} />
    }
  })

  return (
    <div className="menu">
      {menuItems}
    </div>
  )
}

export default Menu;

