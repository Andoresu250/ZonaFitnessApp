class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
	def authenticate_normal_user!
		#LOGIN PATH
		redirect_to root_path unless user_signed_in? && current_user.is_normal_user?		
	end

	def authenticate_trainer!
		#LOGIN PATH
		redirect_to root_path unless user_signed_in? && current_user.is_trainer?
	end

	def authenticate_admin!
		redirect_to root_path unless user_signed_in? && current_user.is_admin?
	end

	def authenticate_super_admin!
		redirect_to root_path unless user_signed_in? && current_user.is_super_admin?
	end

	protected
  	def configure_permitted_parameters
  		devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :cc, :email, :password, :password_confirmation)}  		
  	end

end