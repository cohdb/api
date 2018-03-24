class UsersController < ApplicationController
  before_action :doorkeeper_authorized!, only: :me

  def me
    render json: current_user
  end
end
