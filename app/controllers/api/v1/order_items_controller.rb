class Api::V1::OrderItemsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :load_order, only: [:create]


  def create

    @order_item = OrderItem.new 
    @order_item.food_item_id = params[:order_item][:food_item_id]
    @order.order_items << @order_item

    if @order.save
      url = "/orders/#{@order.id}"
      render :js => "#{url}" 
    end
  end

  private

    def load_order
      @order = Order.find_or_initialize_by(id: session[:order_id], status: "new")

      if @order.new_record?
        @order.save!
        session[:order_id] = @order.id
      end
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