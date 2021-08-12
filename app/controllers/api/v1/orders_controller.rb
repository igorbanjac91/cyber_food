class Api::V1::OrdersController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index]
  before_action :set_order, only: [:show, :update]

  def index 
    if current_user.admin?
      @orders = Order.where.not(status: "new").order(status: :desc, created_at: :desc)
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

  def update
    if authorized?
      respond_to do |format|
        if @order.update!(order_params)
          format.json { render :show, status: :ok }
        else
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  protected

    def set_order 
      @order = Order.find(params[:id])
    end

    def authorized?
      if admin_user?
        return true
      else
        @order.user == current_user || guest_user
      end
    end

    def order_params
      params.require(:order).permit(:status)
    end
end