
class Api::V1::FoodItemsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin_user!, except: [:index, :show]
  before_action :set_food_item, only: [:show]

  def index
    @food_items = FoodItem.all
  end

  def show 
    respond_to do |format|
      format.json { render :show }
    end
  end

  def create
    @food_item = FoodItem.create(food_item_params)
    respond_to do |format|
      if @food_item.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @food_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

  def set_food_item
    @food_item = FoodItem.find(params[:id])
  end

  def food_item_params
    params.require(:food_item).permit(:name, :description, :price, :image)
  end
  
end