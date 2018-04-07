# == Schema Information
#
# Table name: players
#
#  id          :integer          not null, primary key
#  replay_id   :integer          not null
#  internal_id :integer          not null
#  name        :string           not null
#  steam_id    :string           not null
#  faction     :string           not null
#  team        :integer
#  commander   :string
#  cpm         :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_players_on_replay_id  (replay_id)
#

require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'validations' do
    subject { build(:player) }

    it 'has a valid factory' do
      should be_valid
    end

    it 'is invalid without a replay' do
      subject.replay = nil
      should be_invalid
    end

    it 'is invalid without an internal ID' do
      subject.internal_id = nil
      should be_invalid
    end

    it 'is invalid with a non-integer internal ID' do
      subject.internal_id = 1.5
      should be_invalid
    end

    it 'is valid with a negative internal ID' do
      subject.internal_id = -1
      should be_valid
    end

    it 'is valid with an internal ID of 0' do
      subject.internal_id = 0
      should be_valid
    end

    it 'is valid with a positive internal ID' do
      subject.internal_id = 1
      should be_valid
    end

    it 'is invalid without a name' do
      subject.name = nil
      should be_invalid
    end

    it 'is invalid without a Steam ID' do
      subject.steam_id = nil
      should be_invalid
    end

    it 'is invalid without a faction' do
      subject.faction = nil
      should be_invalid
    end

    it 'is invalid with an incorrect faction' do
      subject.faction = 'Not a faction'
      should be_invalid
    end
  end

  describe 'scopes' do
    describe 'for_replay' do
      let!(:player) { create(:player) }
      subject { described_class.for_replay(replay) }

      before do
        create(:player)
      end

      context 'nil input' do
        let(:replay) { nil }

        it 'returns all players' do
          expect(subject.count).to eq(2)
        end
      end

      context 'replay input' do
        let(:replay) { player.replay }

        it 'returns all players for that replay' do
          expect(subject).to contain_exactly(player)
        end
      end

      context 'replay ID input' do
        let(:replay) { player.replay_id }

        it 'returns all players for that replay' do
          expect(subject).to contain_exactly(player)
        end
      end
    end
  end

  describe '.commander_name' do
    let(:player) { build(:player, commander: commander) }
    subject { player.commander_name }

    context 'known commander ID' do
      let(:commander) { 'known' }

      before do
        allow(Relic::Attributes::Commanders).to receive(:to_localized_string).with(commander, :english).and_return('Known Commander')
      end

      it 'returns English localized string for that commander' do
        expect(subject).to eq('Known Commander')
      end
    end

    context 'unknown commander ID' do
      let(:commander) { 'unknown' }

      it 'returns Unknown placeholder' do
        expect(subject).to eq('UNKNOWN')
      end
    end
  end
end
