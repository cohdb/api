# frozen_string_literal: true
# == Schema Information
#
# Table name: replays
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  version          :integer          not null
#  length           :integer          not null
#  map              :string           not null
#  rng_seed         :integer
#  opponent_type    :string
#  game_type        :string
#  recorded_at      :datetime
#  rec_file_name    :string
#  rec_content_type :string
#  rec_file_size    :integer
#  rec_updated_at   :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recorded_at_text :string           default(""), not null
#
# Indexes
#
#  index_replays_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Replay, type: :model do
  describe 'validations' do
    subject { build(:replay) }

    it 'has a valid factory' do
      should be_valid
    end

    it 'is invalid without an opponent type' do
      subject.opponent_type = nil
      should be_invalid
    end

    it 'is invalid with an incorrect opponent type' do
      subject.opponent_type = 'Bad Type'
      should be_invalid
    end

    it 'is invalid without a game type' do
      subject.game_type = nil
      should be_invalid
    end

    it 'is invalid with an incorrect game type' do
      subject.game_type = 'Bad Type'
      should be_invalid
    end

    it 'is invalid without a map' do
      subject.map = nil
      should be_invalid
    end

    it 'is invalid without recorded at text' do
      subject.recorded_at_text = nil
      should be_invalid
    end

    it 'is invalid without a version' do
      subject.version = nil
      should be_invalid
    end

    it 'is invalid with a non-integer version number' do
      subject.version = 1.5
      should be_invalid
    end

    it 'is invalid with a negative version number' do
      subject.version = -1
      should be_invalid
    end

    it 'is invalid with a version number of 0' do
      subject.version = 0
      should be_invalid
    end

    it 'is valid with a natural version number' do
      subject.version = 1
      should be_valid
    end

    it 'is invalid without a length' do
      subject.length = nil
      should be_invalid
    end

    it 'is invalid with a non-integer length' do
      subject.length = 1.5
      should be_invalid
    end

    it 'is invalid with a negative length' do
      subject.length = -1
      should be_invalid
    end

    it 'is valid with a length of 0' do
      subject.length = 0
      should be_valid
    end

    it 'is valid with a positive length' do
      subject.length = 1
      should be_valid
    end

    it 'is invalid without a replay file attached' do
      subject.rec = nil
      should be_invalid
    end

    it 'is invalid with a non-replay file attached' do
      subject.rec = File.new(File.join(Rails.root, '/spec/support/fixtures', 'test_image.jpg'))
      should be_invalid
    end
  end

  describe '.map_resource_id' do
    let(:replay) { build(:replay, map: '$123') }
    subject { replay.map_resource_id }

    it 'strips $ from start of map ID' do
      expect(subject).to eq('123')
    end
  end

  describe '.map_name' do
    let(:replay) { build(:replay, map: map) }
    subject { replay.map_name }

    context 'known map ID' do
      let(:map) { '$known' }

      before do
        allow(Relic::Resources::Collection).to receive(:resource_text).with('known', :english).and_return('Known Map')
      end

      it 'returns English localized string for that map' do
        expect(subject).to eq('Known Map')
      end
    end

    context 'unknown map ID' do
      let(:map) { '$unknown' }

      it 'returns Unknown placeholder' do
        expect(subject).to eq('Unknown')
      end
    end
  end
end
