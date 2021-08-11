
class Api::V1::FoodItemsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin_user!, except: [:index, :show]
  before_action :set_food_item, only: [:show, :update]

  def index
    @food_items = FoodItem.all
  end

  def show 
    respond_to do |format|
      format.json { render :show }
    end
  end

  def create
    @food_item = FoodItem.create!(food_item_params)
    respond_to do |format|
      if @food_item.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @food_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @food_item.update!(food_item_params.except(:image))
        if params[:food_item][:image].present?
          @food_item.image.purge
          @food_item.image.attach(params[:food_item][:image])
        end
        format.json { render :show, status: :ok }
      else      
        format.json { render json: @food_item.erros, status: :unprocessable_entity }
      end
    end
  end

  private 

  def set_food_item
    @food_item = FoodItem.find(params[:id])
  end

  def food_item_params
    params.require(:food_item).permit(:name, :description, :price, :image, :category_id)
  end
  
end