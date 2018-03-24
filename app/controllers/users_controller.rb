class UsersController < ApplicationController
  before_action :doorkeeper_authorize!, only: :me

  def me
    render json: current_user
  end
end
