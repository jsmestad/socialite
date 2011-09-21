module Socialite
  class UsersController < ApplicationController
    unloadable

    respond_to :html, :json

    def new
      respond_with(user)
    end

    def create
      self.user = User.new(params[:user])
      if user.save
        flash_message :success, 'Registration completed. You may now log in.'
      else
        flash_message :error, 'An error occurred. Please try again or contact support.'
      end
      respond_with(user, :location => redirect_back_or_default(root_path))
    end

    def edit
      respond_with(user)
    end

    def update
      flash_message :notice, 'Your account has been removed along with any associated identities.'
      respond_with(user, :location => redirect_back_or_default(root_path))
    end

    def destroy
      user.destroy
      logout!
      flash_message :notice, 'Your account has been removed along with any associated identities.'
      respond_with(user, :location => redirect_back_or_default(root_path))
    end

  private

    def user
      @user = current_user? ? current_user : User.find_by_id(params[:id])
      @user ||= User.new
    end

    def user=(user)
      @user = user
    end

  end
end
