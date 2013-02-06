module Socialite
  class SessionController < ApplicationController
    unloadable

    before_filter :ensure_user, :only => [:destroy]
    before_filter :ensure_no_user, :except => [:destroy]

    respond_to :html, :json

    def new; end

    def create
      @identity = Identity.find_or_initialize_by_oauth(env['omniauth.auth'])
      @identity.build_user if @identity.user.blank?

      if @identity.save
        self.current_user = @identity.user
        flash_message :notice, 'You have logged in successfully.'
      else
        flash_message :error, 'An error occurred. Please try again.'
      end
      respond_with(identity) do |format|
        format.html { redirect_back_or_default }
      end
    end

    def destroy
      logout!
      redirect_to main_app.root_path, notice: 'Signed out!'
    end
  end
end
