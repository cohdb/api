# frozen_string_literal: true
FactoryBot.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    resource_owner_id { create(:user).id }
    token { SecureRandom.uuid }
  end
end
