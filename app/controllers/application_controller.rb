class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
  # sign_inのときに、group_keyも許可する
    devise_parameter_sanitizer.permit(:sign_in, keys:[:sex, :company])
  # sign_upのときに、group_keyも許可する
    devise_parameter_sanitizer.permit(:sign_up, keys:[:sex, :company])
  #account_updateのときに、group_keyも許可する
    devise_parameter_sanitizer.permit(:account_update, keys:[:sex, :company])
  end


end
