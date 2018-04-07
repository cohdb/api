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

RSpec.describe Command do
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
end
