require 'rails_helper'

RSpec.describe Replay do
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

    it 'is invalid with a recorded at time' do
      subject.recorded_at = nil
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
