module Socialite
  class UsersController < ApplicationController
    unloadable

    before_filter :ensure_user
    respond_to :html, :json

    def show
      respond_with(user)
    end

    def edit
      respond_with(user)
    end

    def update
      flash_message :notice, 'Your account has been removed along with any associated identities.'
      respond_with(user) do |format|
        format.html { redirect_back_or_default(user_path) }
      end
    end

    def destroy
      user.destroy
      logout!
      flash_message :notice, 'Your account has been removed along with any associated identities.'
      respond_with(user) do |format|
        format.html { redirect_back_or_default(user_path) }
      end
    end

  private

    def user
      @user = current_user
    end
  end
end
