module Socialite
  class SessionController < ApplicationController
    unloadable

    before_filter :ensure_user, :only => [:destroy]
    before_filter :ensure_no_user, :except => [:destroy]

    respond_to :html, :json

    # Render the login page.
    def new
      respond_with(@user = User.new)
    end

    # Destroy the session, logging out the current user.
    def destroy
      @user = current_user
      if logout!
        flash_message :notice, 'You have been logged out.'
      else
        flash_message :error, 'We had trouble signing you out.'
      end
      respond_with(@user) do |format|
        format.html { redirect_to Socialite.root_path }
      end
    end
  end
end
