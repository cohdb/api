class PlayersController < ApplicationController
  def index
    @players = policy_scope(Player).for_replay(params[:replay_id])
    render json: @players
  end
end
