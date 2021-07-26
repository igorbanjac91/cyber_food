class Api::V1::OrdersController < ApplicationController
  skip_before_action :authenticate_user!

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
   
  end
end