class CommandsController < ApplicationController
  def index
    @commands = policy_scope(Command).for_player(params[:player_id])

    render json: @commands
  end
end
