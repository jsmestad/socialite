module Socialite
  class AuthenticationController < ApplicationController
    unloadable

    def new
      if current_user?
        flash_message :notice, 'You are already signed in.'
        redirect_to(root_path)
      end
    end

    def callback
      provider = request.env['omniauth.auth']['provider']
      user = User.create_or_update_by_identity(provider, request.env['omniauth.auth'])
      self.current_user = user
      flash_message :notice, 'You have logged in successfully.'
      redirect_back_or_default(root_path)
    end


    def destroy
      logout!
      redirect_to(root_path)
    end

  end
end
