class UserSerializer < ApplicationSerializer
  set_type :user
  attributes :id, :provider, :uid, :name, :nickname, :location, :image
end
