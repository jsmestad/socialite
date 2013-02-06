module Socialite
  class IdentitiesController < ApplicationController
    unloadable

    before_filter :ensure_user, :only => [:destroy]
    respond_to :html, :json

    def new
      @identity = env['omniauth.identity'] ||= User.new
    end

    def failure
      flash_message :error, 'We had trouble signing you in. Did you make sure to grant access? Please select a service below and try again.'
      respond_with do |format|
        format.html { redirect_back_or_default }
      end
    end

    def destroy
      if identity.destroy
        logout! if identities.count == 0
        flash_message :notice, 'Identity has been unlinked.'
      else
        flash_message :error, 'We had trouble unlinking this service.'
      end
      respond_with(identity) do |format|
        format.html { redirect_back_or_default }
      end
    end

  private

    def identities
      @identities = current_user.identities
    end

    def identity
      @identity ||= current_user.identities.find(params[:id])
    end
  end
end
