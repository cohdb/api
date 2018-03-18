class ReplaysController < ApplicationController
  def index
    @replays = policy_scope(Replay)

    render json: @replays
  end

  def show
    @replay = policy_scope(Replay).find(params[:id])

    render json: @replay
  end
end

# class ReplaysController < ApplicationController
#   include Vault
#
#   def index
#     @replays = policy_scope(Replay)
#   end
#
#   def show
#     respond_to do |format|
#       format.html do
#         @props = react_props
#         render 'site/index'
#       end
#
#       format.json do
#         @replays = policy_scope(Replay).find(params[:id])
#         @players = policy_scope(@replays.players)
#         @users = @replays.user
#         Player.load_steam_avatar_urls(@players)
#       end
#     end
#   end
#
#   def create
#     ptr = Vault.parse_to_cstring(params[:rec].path)
#     replay_json = JSON.parse(ptr.read_string)
#     Vault.free_cstring(ptr)
#
#     @replays, @players = Replay.create_from_json(replay_json, current_user, params[:rec])
#     render 'show.json'
#   end
#
#   def download
#     @replay = Replay.find(params[:replay_id])
#     raise_404 unless @replay.rec.exists?
#     redirect_to @replay.rec.expiring_url(60)
#   end
#
#   private
#
#   def steam_avatars
#     steam_ids = @replay.players.map(&:steam_id)
#     summaries = Steam::User.summaries(steam_ids)
#
#     avatars = {}
#     summaries.each do |summary|
#       avatars[summary['steamid']] = summary['avatar']
#     end
#
#     avatars
#   end
# end
