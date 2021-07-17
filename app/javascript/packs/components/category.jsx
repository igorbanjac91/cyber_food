import React from "react"

import PropTypes from "prop-types"

const Category = (props) => {

  const { category } = props

  return (
    <li>
      <img src={category.image_url} alt={category.name} width="100"></img>
      <h3>{category.name}</h3>
    </li>
  )
}

export default Category;

Category.propTypes = {
  category: PropTypes.object.isRequired
}