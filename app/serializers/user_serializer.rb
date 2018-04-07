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

class UserSerializer < ApplicationSerializer
  set_type :user
  attributes :id, :provider, :uid, :name, :nickname, :location, :image
end
