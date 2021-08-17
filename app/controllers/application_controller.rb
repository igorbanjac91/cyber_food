class ApplicationController < ActionController::Base
	include ApplicationHelper
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	def authenticate_admin_user!
		unless user_signed_in? && current_user.admin?
			redirect_to log_in_path, status: 401
		end
	end

	def handle_unauthorized
		unless authorized?
			respond_to do |format|
				format.json { render :unauthorized, status: 401 }
			end
		end
	end

	protected 

		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
		end
end
