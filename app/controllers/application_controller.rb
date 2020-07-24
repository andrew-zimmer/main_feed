class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    rescue_from CanCan::AccessDenied do |exception|
        flash[:error] = exception.message
        redirect_to root_url
    end

    def current_user_admin?
        current_user.admin?
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number])
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :role])

    end
end
