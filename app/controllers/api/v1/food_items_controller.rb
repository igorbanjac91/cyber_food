class Api::V1::FoodItemsController < ApplicationController
  
  def index
    @food_items = FoodItems.all
  end
end