# frozen_string_literal: true
class ReplaysController < ApplicationController
  def index
    @replays = policy_scope(Replay).filter(params).order_by(params).page(params)

    render json: @replays
  end

  # def index
  #   @replays = policy_scope(Replay).includes(:players)
  #                                  .for_user(params[:user_id])
  #                                  .after(params[:after])
  #                                  .limit(params[:limit])
  #                                  .order(id: :desc)
  #   @players = policy_scope(Player).where(replay_id: @replays.map(&:id))
  #   Player.load_steam_avatar_urls(@players)
  #   render json: @replays, include: params[:include]&.split(','), meta: { next_cursor: @replays.last&.id }
  #   # render json: ReplaySerializer.new(@replays, include: [:players])
  # end

  def show
    @replay = policy_scope(Replay).find(params[:id])
    Player.load_steam_avatar_urls(@replay.players)
    render json: @replay
  end

  def create
    authorize Replay.new(permitted_attributes(Replay))
    @replay, @players = Replay.create_from_file(permitted_attributes(Replay))
    Player.load_steam_avatar_urls(@players)
    render json: @replay
  end
end
