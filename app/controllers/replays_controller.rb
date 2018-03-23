class ReplaysController < ApplicationController
  def index
    @replays = policy_scope(Replay).includes(:players)
    render json: @replays
  end

  def show
    @replay = policy_scope(Replay).find(params[:id])
    render json: @replay
  end

  def create
    authorize Replay.new(permitted_attributes(Replay))
    @replay, @players = Replay.create_from_file(permitted_attributes(Replay))
    render json: @replay
  end
end
