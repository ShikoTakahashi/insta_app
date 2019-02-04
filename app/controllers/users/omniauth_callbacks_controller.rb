# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def facebook
    callback_from :facebook
  end

  def callback_from(provider)
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session['devise.user_attributes'] = request.env['omniauth.auth']
      @user = User.new()
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
