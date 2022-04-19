class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_application_variables
    helper_method :signed_in_user 

    def signed_in_user
      return current_user 
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
      devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :first_name, :last_name, :password, :password_confirmation, :email) }
    end

    def set_application_variables
      @avatar = "default.png"
      @signed_in = current_user 
      @has_avatar = current_user.avatar.persisted? if @signed_in
      @avatar = url_for(current_user.avatar) if @signed_in && @has_avatar 
    end
end
