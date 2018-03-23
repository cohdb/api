class AuthController < ApplicationController
  def create
    @access_token = User.login_with_token(params[:login_token])

    render json: @access_token
  end
end
