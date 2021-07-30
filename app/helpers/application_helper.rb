module ApplicationHelper

  def current_order
    if session[:order_id]
      @order ||= Order.find(session[:order_id])
    end
	end

  def flash_messages
    flash.map do |type, text|
      { id: text.object_id, type: type, text: text }
    end
  end
end
