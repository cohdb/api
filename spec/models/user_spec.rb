require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    subject { build(:user) }

    it 'has a valid factory' do
      should be_valid
    end

    it 'is invalid without a provider' do
      subject.provider = nil
      should be_invalid
    end

    it 'is invalid without a uid' do
      subject.uid = nil
      should be_invalid
    end
  end
end
