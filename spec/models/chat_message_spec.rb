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

require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
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

  describe 'scopes' do
    describe 'for_player' do
      let!(:chat_message) { create(:chat_message) }
      subject { described_class.for_player(player) }

      before do
        create(:chat_message)
      end

      context 'nil input' do
        let(:player) { nil }

        it 'returns all players' do
          expect(subject.count).to eq(2)
        end
      end

      context 'player input' do
        let(:player) { chat_message.player }

        it 'returns all players for that player' do
          expect(subject).to contain_exactly(chat_message)
        end
      end

      context 'player ID input' do
        let(:player) { chat_message.player_id }

        it 'returns all players for that player' do
          expect(subject).to contain_exactly(chat_message)
        end
      end
    end

    describe 'for_replay' do
      let!(:chat_message) { create(:chat_message) }
      subject { described_class.for_replay(replay) }

      before do
        create(:chat_message)
      end

      context 'nil input' do
        let(:replay) { nil }

        it 'returns all chat messages' do
          expect(subject.count).to eq(2)
        end
      end

      context 'replay input' do
        let(:replay) { chat_message.player.replay }

        it 'returns all chat messages for that replay' do
          expect(subject).to contain_exactly(chat_message)
        end
      end

      context 'replay ID input' do
        let(:replay) { chat_message.player.replay_id }

        it 'returns all chat messages for that replay' do
          expect(subject).to contain_exactly(chat_message)
        end
      end
    end
  end
end
