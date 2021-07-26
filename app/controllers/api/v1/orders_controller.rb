class Api::V1::OrdersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def show 
    respond_to do |format|
      format.json { render :show }
    end
  end

  protected

    def set_order 
      @order = Order.find(params[:id])
    end
end