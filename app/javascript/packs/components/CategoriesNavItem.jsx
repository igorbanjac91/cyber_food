import React from "react"

import PropTypes from "prop-types"

const CategoriesNavItem = (props) => {

  const { category } = props

  return (
    <li className="category">
      <a href="#">
        <div 
          className="category__image-container"
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
