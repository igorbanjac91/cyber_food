class Api::V1::OrdersController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index, :show]
  before_action :set_order, only: [:show]

  def index 
    if current_user.admin?
      @orders = Order.all
    else
      @orders = current_user.orders
    end
  end
  
  def show 
    if authorized?
      respond_to do |format|
        format.json { render :show }
      end
    else
      handle_unauthorized
    end
  end


  protected

    def set_order 
      @order = Order.find(params[:id])
    end

    def authorized?
      @order.user == current_user || current_user.admin?
    end
end