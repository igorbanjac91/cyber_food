class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	def authenticate_admin_user!
		unless user_signed_in? && current_user.admin?
			redirect_to log_in_path, status: 401
		end
	end
end
