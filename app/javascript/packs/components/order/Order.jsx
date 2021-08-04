import React, { useEffect, useState } from "react"
import { useParams } from "react-router";
import axios from "axios";

import OrderItems from "./OrderItems";
import setAxiosHeaders from "../AxiosHeaders";

const Order = () => {

  let { id } = useParams();
  const [ order, setOrder ] = useState([]);
  const [ orderItems, setOrderItems ] = useState([]);

  useEffect(() => {
    getOrder()
    addAttributeToForm()
  }, [])

  
  function getOrder() {
    axios
    .get(`/api/v1/orders/${id}`)
    .then( (response) => {
      const fetchedOrder = response.data;
      setOrder(fetchedOrder);
      setOrderItems(fetchedOrder.order_items);
    })   
  }


  function changeQuantity(id, quantity) {
    if (quantity == 0) {
      destroyOrderItem(id)
    }

    setAxiosHeaders();

    let params = { 
      order_item: {
        quantity: quantity
      }    
    }

    findAndReplaceQuantity(id, quantity)

    axios
      .put(`/api/v1/order_items/${id}`, params)
      .then( response => {
        console.log(response);
      }).catch( error => {
        console.log(error);
      } )

    function findAndReplaceQuantity(id, quantity) {
      let newOrderItems = orderItems.map( (orderItem) => {
        if (orderItem.id == id) {
          orderItem.quantity = quantity;
        }
        return orderItem
      })
      setOrderItems(newOrderItems);
    }
  }
  

  function destroyOrderItem(id) {
    setAxiosHeaders()
    axios
      .delete(`/api/v1/order_items/${id}`)
      .then(response => {
        getOrder()
      }).catch( error => {
        console.log(error)
      })
  }

  function handleCheckout(e) {
    e.preventDefault()
    setAxiosHeaders()

    let params = { order_id: order.id }

    axios
      .post("/checkout", params)
      .then(response => {
        window.location.href = response.data.url
      }).catch(error => {
        console.log(error)
      })
  }

  function addAttributeToForm() {
    let form = document.querySelector(".checkout-form")
    console.log(form)
    form.setAttribute("data-remote", "true");
  }

  let total = orderItems.reduce((acc, curr) => {
    console.log("dfsfdfsdf")
    return acc + Number(curr.food_item.price) * curr.quantity
  }, 0)

  return (
    <div className="cart">
      <h2 className="cart__heading" >Cart</h2>
      <OrderItems order={order} orderItems={orderItems} changeQuantity={changeQuantity}/>
      <div className="line"></div>
      <div className="cart__total">
        <span>Total</span>
        <span>$ {total}</span>
      </div>
      <div className="cart__actions">
        <form className="checkout-form" onSubmit={handleCheckout} >
          <button className="checkout-btn">Checkout</button>
        </form>
        <a className="back-to-menu" href="/">Back To Menu</a>
      </div>
    </div>
  )
}

export default Order;