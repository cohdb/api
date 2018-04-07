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

class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: [:steam]

  has_many :access_grants, class_name: 'Doorkeeper::AccessGrant',
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all, # or :destroy if you need callbacks
                           inverse_of: :user
  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken',
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all, # or :destroy if you need callbacks
                           inverse_of: :user

  validates :provider, presence: true
  validates :uid, presence: true

  def generate_login_token
    raw, enc = Devise.token_generator.generate(self.class, :login_token)

    self.login_token = enc
    self.login_token_sent_at = Time.now.utc
    save!(validate: false)
    raw
  end

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create!
    user.update(auth['info'].except('urls').to_h)
    user
  end

  def self.login_with_token(original_token)
    login_token = Devise.token_generator.digest(self, :login_token, original_token)
    user = find_by!(login_token: login_token)
    Doorkeeper::AccessToken.create!(resource_owner_id: user.id)
  end
end
