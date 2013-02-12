module Socialite
  class UsersController < ApplicationController
    unloadable

    def new
      @user = env['omniauth.identity'] ||= Socialite.user_class.new
    end
  end
end
