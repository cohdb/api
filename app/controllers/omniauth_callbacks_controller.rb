class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # skip_before_action :verify_authenticity_token, only: :steam

  def steam
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      # sign_in @user, event: :authentication
      # raw, enc = Devise.token_generator.generate(self.class, :login_token)
      token = @user.generate_login_token
      redirect_to "http://localhost:4000/auth?login_token=#{token}"
      # sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      # set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      # session['devise.steam_data'] = request.env['omniauth.auth']
      # redirect_to new_user_registration_url
      raise 'NOT PERSISTED'
    end
  end

  def failure
    raise 'FAILURE'
    # redirect_to root_path
  end
end
