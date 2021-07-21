class Api::V1::OrdersController < ApplicationController

  def show

  end


  def create 
    # create a new order
    # add the order_item to that order
    # if valid and saved 
    # redirect to the order page 
    # else 
    # remain on the home pate and return an error
    @order = Order.build
    @order_item = @order.order_items.build
    @order_item.quantity = params[:order_item][:quantity]
    @order_item.food_item_id = params[:order_item][:food_item_id]
    if @order.save?
      render :show
    end
  end
end