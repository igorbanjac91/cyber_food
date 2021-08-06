module ApplicationHelper

  def current_order
    if session[:order_id]
      @order ||= Order.find(session[:order_id])
    end
	end

  def current_order?
    !session[:order_id].nil?
  end

  def flash_messages
    flash.map do |type, text|
      { id: text.object_id, type: type, text: text }
    end
  end

  def guest_user 
    if session[:guest_id]
      @guest_user ||= User.find(session[:guest_id])
    end
  end

  def admin_user?
		if user_signed_in?
			return true if current_user.admin?
		end
	end
end
