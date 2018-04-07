# frozen_string_literal: true
# == Schema Information
#
# Table name: commands
#
#  id                 :integer          not null, primary key
#  player_id          :integer          not null
#  internal_player_id :integer          not null
#  tick               :integer          not null
#  command_type       :string           not null
#  entity_id          :integer          not null
#  x                  :decimal(, )
#  y                  :decimal(, )
#  z                  :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_commands_on_player_id  (player_id)
#

require 'rails_helper'

RSpec.describe Command, type: :model do
  describe 'validations' do
    subject { build(:command) }

    it 'has a valid factory' do
      should be_valid
    end

    it 'is invalid without a player' do
      subject.player = nil
      should be_invalid
    end

    it 'is invalid without an internal player ID' do
      subject.internal_player_id = nil
      should be_invalid
    end

    it 'is invalid with a non-integer internal player ID' do
      subject.internal_player_id = 1.5
      should be_invalid
    end

    it 'is valid with a negative internal player ID' do
      subject.internal_player_id = -1
      should be_valid
    end

    it 'is valid with an internal player ID of 0' do
      subject.internal_player_id = 0
      should be_valid
    end

    it 'is valid with a positive internal player ID' do
      subject.internal_player_id = 1
      should be_valid
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

    it 'is invalid without a command type' do
      subject.command_type = nil
      should be_invalid
    end

    it 'is invalid without an entity ID' do
      subject.entity_id = nil
      should be_invalid
    end

    it 'is invalid with a non-integer entity ID' do
      subject.entity_id = 1.5
      should be_invalid
    end

    it 'is valid with a negative entity ID' do
      subject.entity_id = -1
      should be_valid
    end

    it 'is valid with an entity ID of 0' do
      subject.entity_id = 0
      should be_valid
    end

    it 'is valid with a positive entity ID' do
      subject.entity_id = 1
      should be_valid
    end
  end

  describe 'scopes' do
    describe 'for_player' do
      let!(:command) { create(:command) }
      subject { described_class.for_player(player) }

      before do
        create(:command)
      end

      context 'nil input' do
        let(:player) { nil }

        it 'returns all players' do
          expect(subject.count).to eq(2)
        end
      end

      context 'player input' do
        let(:player) { command.player }

        it 'returns all players for that player' do
          expect(subject).to contain_exactly(command)
        end
      end

      context 'player ID input' do
        let(:player) { command.player_id }

        it 'returns all players for that player' do
          expect(subject).to contain_exactly(command)
        end
      end
    end
  end

  describe '.entity_name' do
    let(:command) { build(:command, entity_id: entity_id) }
    subject { command.entity_name }

    context 'entity ID is zero' do
      let(:entity_id) { 0 }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'entity ID is known' do
      let(:entity_id) { 1 }

      before do
        allow(CommandTypes).to receive(:entity_name_functions).and_return(command.command_type => proc { |id| "Entity #{id}" })
      end

      it 'returns calculated entity name' do
        expect(subject).to eq('Entity 1')
      end
    end

    context 'entity ID is unknown' do
      let(:entity_id) { 1 }

      before do
        allow(CommandTypes).to receive(:entity_name_functions).and_return({})
      end

      it 'returns unknown placeholder' do
        expect(subject).to eq('UNHANDLED 1')
      end
    end
  end

  describe '.command_text' do
    let(:command) { build(:command, command_type: command_type, x: 1, y: 2, z: 3) }
    subject { command.command_text }

    before do
      allow(command).to receive(:entity_name).and_return('entity')
    end

    context 'command type is known' do
      let(:command_type) { 'known' }

      before do
        allow(CommandTypes).to receive(:command_text_functions).and_return(command_type => proc { |c| "Issues #{c.command_type} with #{c.entity_name}" })
      end

      it 'returns calculated command text' do
        expect(subject).to eq('Issues known with entity')
      end
    end

    context 'command type is unknown' do
      let(:command_type) { 'unknown' }

      it 'returns unknown placeholder' do
        expect(subject).to eq('Issues unknown with entity at 1.0 2.0 3.0')
      end
    end
  end
end
