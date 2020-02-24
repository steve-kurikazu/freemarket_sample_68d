class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:firstname,:lastname,:firstname_kana,:lastname_kana,:birth_year,:birth_month,:birth_day,:tell])
  end
end
