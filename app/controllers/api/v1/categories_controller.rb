class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin_user!, except: [:index, :show]
  before_action :set_category, only: [:show, :update, :destroy]

  def index 
    @categories = Category.all
  end

  def show 
    respond_to do |format|
      format.json { render :show }
    end
  end

  def create 
    @category = Category.new(category_params.except(:image))
    respond_to do |format|
      if @category.save
        if params[:category][:image].present?
          @category.image.attach(params[:category][:image])
        end
        format.json { render :show, status: :created }
      else
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update!(category_params.except(:image))
        if params[:category][:image].present?
          @category.image.purge
          @category.image.attach(params[:category][:image])
        end
        format.json { render :show, status: :ok }
      else
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.json { head :no_content }
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
