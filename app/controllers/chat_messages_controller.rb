class ChatMessagesController < ApplicationController
  def index
    @chat_messages = policy_scope(ChatMessage).for_player(params[:player_id])
                                              .for_replay(params[:replay_id])
    render json: @chat_messages
  end
end
