# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  provider            :string           not null
#  uid                 :string           not null
#  name                :string
#  nickname            :string
#  location            :string
#  image               :string
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :inet
#  last_sign_in_ip     :inet
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  login_token         :string
#  login_token_sent_at :datetime
#
# Indexes
#
#  index_users_on_uid  (uid) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
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
