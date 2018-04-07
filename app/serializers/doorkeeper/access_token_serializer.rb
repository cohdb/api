# frozen_string_literal: true
class Doorkeeper::AccessTokenSerializer < ApplicationSerializer
  set_type :access_token
  attributes :id, :token
end
