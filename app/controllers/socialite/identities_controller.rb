module Socialite
  class IdentitiesController < ApplicationController
    unloadable

    before_filter :require_sign_in, :only => [:index, :destroy]

    respond_to :html, :json

    def index
      respond_with(identities)
    end

    def callback
      provider = request.env['omniauth.auth']['provider']
      user = User.create_or_update_by_identity(provider, request.env['omniauth.auth'])
      if user.save
        self.current_user ||= identity.user
        flash_message :notice, 'You have logged in successfully.'
      else
        flash_message :error, 'An error occurred. Please try again.'
      end
      respond_with(identity, :location => redirect_back_or_default(root_path))
    end

    def failure
      flash_message :error, 'We had trouble signing you in. Did you make sure to grant access? Please select a service below and try again.'
      render :action => 'new'
    end

    def destroy
      identity.destroy
      respond_with(identity, :location => redirect_back_or_default(root_path))
    end

    private

      def identities
        @identities = current_user.identities
      end

      def identity
        @identity = current_user.identities.find(params[:identity_id] || params[:id])
      end
  end
end
