class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def new
    auth_options = { :recall => 'static_pages#home', :scope => :user }
    resource = warden.authenticate!(auth_options)
    super
  end

  # POST /resource/sign_in
  def create
    auth_options = { :recall => 'static_pages#home', :scope => :user }
    resource = warden.authenticate!(auth_options)
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:password])
  end
end
