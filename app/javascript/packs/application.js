// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
// Turbolinks.start()
ActiveStorage.start()

/* Burger Menu */

document.addEventListener("DOMContentLoaded", function() {
  let menuIcon = document.querySelector("#main-menu-icon");
  const menu = document.querySelector(".main-nav");
  
  window.addEventListener("click", (e) => {
    if (e.target == menuIcon) {
      e.preventDefault()
      if (!Array.from(menu.classList).includes('show-menu')) {
        menu.classList.add("show-menu");
      } else {
        menu.classList.remove("show-menu");
      }
    } else {
      menu.classList.remove("show-menu");
    }
  })
  
})

