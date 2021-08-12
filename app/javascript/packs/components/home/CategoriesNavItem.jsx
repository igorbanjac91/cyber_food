import React from "react"

const CategoriesNavItem = (props) => {

  const { category } = props

  function handleFilterByCategory(e) {
    e.preventDefault()
    props.filterByCategory(category)
  }

  return (
    <li className="category-nav-item">
      <a onClick={handleFilterByCategory} className="category-nav-item__link">
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
