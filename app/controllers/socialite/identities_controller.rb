module Socialite
  class IdentitiesController < ApplicationController
    unloadable

    before_filter :ensure_user, :only => [:destroy]
    respond_to :html, :json

    def create
      auth_hash = request.env['omniauth.auth']
      identity = Identity.find_or_initialize_by_oauth(auth_hash)
      identity.build_user if identity.user.blank?

      if identity.save
        self.current_user ||= identity.user
        flash_message :notice, 'You have logged in successfully.'
      else
        flash_message :error, 'An error occurred. Please try again.'
      end
      respond_with(identity) do |format|
        format.html { redirect_back_or_default(Socialite.root_path) }
      end
    end

    def failure
      flash_message :error, 'We had trouble signing you in. Did you make sure to grant access? Please select a service below and try again.'
      respond_with do |format|
        format.html { redirect_back_or_default(Socialite.root_path) }
      end
    end

    def destroy
      if identity.destroy
        flash_message :notice, 'Identity has been unlinked.'
      else
        flash_message :error, 'We had trouble unlinking this service.'
      end
      respond_with(identity) do |format|
        format.html { redirect_back_or_default(Socialite.root_path) }
      end
    end

    private

      def identities
        @identities = current_user.identities
      end

      def identity
        @identity = current_user.identities.find(params[:id])
      end
  end
end
