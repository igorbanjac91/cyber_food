class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :create]
  before_action :set_category, only: [:show]

  def index 
    @categories = Category.all
  end

  def show 
    respond_to do |format|
      format.json { render :show }
    end
  end

  def create 
    puts params.inspect
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

    def set_category
      @category = Category.find(params[:id])
    end
    
    def category_params
      params.require(:category).permit(:name, :image)
    end
end
