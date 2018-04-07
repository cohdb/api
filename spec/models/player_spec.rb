require 'rails_helper'

RSpec.describe Player do
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
end
