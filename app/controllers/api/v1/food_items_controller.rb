class Api::V1::FoodItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_food_item, only: [:show]

  def index
    @food_items = FoodItem.all
  end

  def show 
    respond_to do |format|
      format.json { render :show }
    end
  end

  private 

  def set_food_item
    @food_item = FoodItem.find(params[:id])
  end
end