import React from "react"

const CategoriesNavItem = (props) => {

  const { category } = props

  return (
    <li className="category-nav-item">
      <a href="#">
        <div 
          className="category-nav-item__image-container"
          style={{
            backgroundImage: `url(${category.image_url})`
          }}
          >
        </div>
        <h3>{category.name}</h3>
      </a>
    </li>
  )
}

export default CategoriesNavItem;
