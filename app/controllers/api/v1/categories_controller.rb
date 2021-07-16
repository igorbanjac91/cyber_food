class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_category, only: [:show]

  def index 
    @categories = Category.all
  end

  def show 
    respond_to do |format|
      format.json { render :show }
    end
  end


  private 

    def set_category
      @category = Category.find(params[:id])
    end
end
