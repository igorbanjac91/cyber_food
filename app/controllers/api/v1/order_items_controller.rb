class Api::V1::OrderItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  before_action :load_order, only: [:create]
    
  def create

    if authorized?
      @order_item = OrderItem.new 
      @order_item.food_item_id = params[:order_item][:food_item_id]
      @order.order_items << @order_item

      respond_to do |format|
        if @order.save
          # url = "/orders/#{@order.id}"
          # render :js => "#{url}" 
          format.json { render json: "order item created", status: :created }
        else
          format.json { render json: @todo_item.errors, status: :unprocessable_entity }
        end
      end
    else
      handle_unauthorized
    end

  end

  private

    def load_order
      @order = Order.find_or_initialize_by(id: session[:order_id], status: "new")

      if @order.new_record?
        @order.user = current_user
        @order.save!
        session[:order_id] = @order.id
      end
    end

    def authorized?
      # if @order.user == current_user
      #   return true
      # end
      true
    end

    def handle_unauthorized
      unless authorized?
        respond_to do |format|
          format.json { render :unauthorized, status: 401 }
        end
      end
    end

    def order_item_params
      params.require(:order_item).permit(:quantity, :food_item_id)
    end
end