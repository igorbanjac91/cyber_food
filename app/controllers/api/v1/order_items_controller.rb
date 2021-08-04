class Api::V1::OrderItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :load_order, only: [:create, :update]
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
          flash[:success] = "Added #{food_item.name} to your order"
          @flash_messages = flash_messages
          @order
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
    if authorized?
      respond_to do |format| 
        if @order_item.update(order_item_params) 
          format.json { render :show, status: :ok }
        else
          format.json { render json: @order_item.errors, status: :unprocessable_entity }
        end
      end
    else
      handle_unauthorized
    end
  end

  def destroy
    if authorized?
      @order_item.destroy
      respond_to do |format| 
        format.json { head :no_content}
      end
    else
      handle_unauthorized
    end
  end

  private

    def load_order
      @order = Order.find_or_initialize_by(id: session[:order_id], status: "new")

      if @order.new_record?
        if user_signed_in? 
          @order.user = current_user
        else
          user = User.new_guest
          GuestsCleanupJob.set(wait: 1.week).perform_later(user)
          @order.user = user
          session[:guest_id] = user.id
        end
        @order.save!
        session[:order_id] = @order.id
      end
    end

    def authorized?
      if @order_item 
        if @order_item.order.user == current_user || guest_user
          return true
        end
      elsif @order.user == current_user || guest_user
        return true
      end
    end

    def handle_unauthorized
      respond_to do |format|
        format.json { render :unauthorized, status: 401 }
      end
    end

    def order_item_params
      params.require(:order_item).permit(:quantity, :food_item_id)
    end 

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end
end