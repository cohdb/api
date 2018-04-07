# frozen_string_literal: true
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # skip_before_action :verify_authenticity_token, only: :steam

  def steam
    @user = User.from_omniauth(request.env['omniauth.auth'])

    raise 'NOT PERSISTED' unless @user.persisted?
    token = @user.generate_login_token
    redirect_to "#{ENV['MAIN_FRONTEND_URL']}/auth?login_token=#{token}"
  end

  def failure
    raise 'FAILURE'
  end
end
