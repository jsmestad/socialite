module Socialite
  class SessionsController < ApplicationController
    unloadable

    before_filter :ensure_user, :only => [:destroy]
    before_filter :ensure_no_user, :except => [:destroy]

    respond_to :html, :json

    # Render the login page
    def new
      respond_with(@user = User.new)
    end

    def create
      # do actual authentication
    end

    def failure

    end

    def destroy
      logout!
      respond_with(user, :location => root_path)
    end

  end
end
