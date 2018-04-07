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

require 'rails_helper'

RSpec.describe ChatMessage do
  describe 'validations' do
    subject { build(:chat_message) }

    it 'has a valid factory' do
      should be_valid
    end

    it 'is invalid without a player' do
      subject.player = nil
      should be_invalid
    end

    it 'is invalid without a tick' do
      subject.tick = nil
      should be_invalid
    end

    it 'is invalid with a non-integer tick' do
      subject.tick = 1.5
      should be_invalid
    end

    it 'is invalid with a negative tick' do
      subject.tick = -1
      should be_invalid
    end

    it 'is valid with a tick of 0' do
      subject.tick = 0
      should be_valid
    end

    it 'is valid with a positive tick' do
      subject.tick = 1
      should be_valid
    end
  end
end
