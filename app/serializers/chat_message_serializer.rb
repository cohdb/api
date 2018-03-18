class ChatMessageSerializer < ApplicationSerializer
  set_type :chat_message
  attributes :id, :player_id, :tick, :message
end
