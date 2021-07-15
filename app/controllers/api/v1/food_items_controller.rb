class Api::V1::FoodItemsController < ApplicationController
  
  def index
    @food_items = FoodItems.all
  end

  def show 
    respond_to do |format|
      format.json { render :show }
    end
  end

end