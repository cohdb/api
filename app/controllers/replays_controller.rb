class ReplaysController < ApplicationController
  def index
    @replays = policy_scope(Replay)
    render json: @replays
  end

  def show
    @replay = policy_scope(Replay).find(params[:id])
    render json: @replay
  end

  def create
    @replay, @players = Replay.create_from_file(params[:rec], current_user)
    render json: @replay
  end
end
