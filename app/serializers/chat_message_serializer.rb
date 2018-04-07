# frozen_string_literal: true
# == Schema Information
#
# Table name: chat_messages
#
#  id         :integer          not null, primary key
#  player_id  :integer          not null
#  tick       :integer          not null
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chat_messages_on_player_id  (player_id)
#

class ChatMessageSerializer < ApplicationSerializer
  set_type :chat_message
  attributes :id, :player_id, :tick, :message
end
