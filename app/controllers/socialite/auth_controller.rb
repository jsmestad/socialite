module Socialite
  class AuthController < ApplicationController
    unloadable

    def new
      if current_user?
        flash[:notice] = 'You are already signed in. Please sign out if you want to sign in as a different user.'
        redirect_to(root_path)
      end
    end

    def callback
      account = case request.env['omniauth.auth']['provider']
        when 'twitter' then
          Socialite::TwitterAccount.find_or_create_from_auth_hash(request.env['omniauth.auth'])
        when 'facebook' then
          Socialite::FacebookAccount.find_or_create_from_auth_hash(request.env['omniauth.auth'])
        when 'linked_in' then
          Socialite::LinkedInAccount.find_or_create_from_auth_hash(request.env['omniauth.auth'])
        when 'github' then
          Socialite::GithubAccount.find_or_create_from_auth_hash(request.env['omniauth.auth'])
      end

      self.current_user = account.find_or_create_user

      flash[:notice] = 'You have logged in successfully.'
      redirect_back_or_default(root_path)
    end

    def failure
      flash[:error] = "We had trouble signing you in. Did you make sure to grant access? Please select a service below and try again."
      render :action => 'new'
    end

    def destroy
      logout!
      redirect_to(root_path)
    end
  end
end
