class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: [:steam]

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create!
    user.update(auth['info'].except('urls').to_h)
    user
  end
end
