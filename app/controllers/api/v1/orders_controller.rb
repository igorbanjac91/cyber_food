class Api::V1::OrdersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def show 
    if authorized?
      respond_to do |format|
        format.json { render :show }
      end
    else
      handle_unauthorized
    end
  end

  def create 
    if user_signed_in?
      @order = current_user.order.create
    else 
      @order = Order.create
    end
    
    @order_item = OrderItem.new 
    @order_item.food_item_id = params[:order_item][:food_item_id]
    @order.order_items << @order_item
    if @order.save
      redirect_to "/orders/#{@order.id}"
    end
  end

  private 

    def set_order
      @order = Order.find(params[:id])
    end

    def authorized?
      @order.user == current_user || @order.user == guest_user
    end

    def handle_unauthorized
      unless authorized?
        respond_to do |format|
          format.json { render :unauthorized, status: 400 }
        end
      end
    end

    def order_item_params
      params.require(:order_item).permit(:quantity, :food_item_id)
    end
end