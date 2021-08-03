class Api::V1::OrderItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :load_order, only: [:create]
  before_action :set_order_item, only: [:update, :destroy]
  
    
  def create

    if authorized?
      @order_item = @order.order_items.find_or_initialize_by(food_item_id: params[:order_item][:food_item_id])

      if @order_item.new_record?
        @order_item.quantity = 1
      else
        @order_item.quantity += 1
      end

      respond_to do |format|
        if @order_item.save
          food_item = @order_item.food_item
          # @message = "Add #{food_item.name} to your order"
          # @type = "success"
          flash[:success] = "Added #{food_item.name} to your order"
          @flash_messages = flash_messages
          format.json { render :flash_messages, status: :created }
        else
          format.json { render json: @todo_item.errors, status: :unprocessable_entity }
        end
      end
    else
      handle_unauthorized
    end

  end

  def update 
    respond_to do |format| 
      if @order_item.update(order_item_params) 
        format.json { render :show, status: :ok }
      else
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_item.destroy
    respond_to do |format| 
      format.json { head :no_content}
    end
  end

  private

    def load_order
      @order = Order.find_or_initialize_by(id: session[:order_id], status: "new")

      if @order.new_record?
        if user_signed_in? 
          @order.user = current_user
        end
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

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end
end