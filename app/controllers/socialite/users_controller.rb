module Socialite
  class UsersController < SocialiteController
    unloadable

    def new
      if current_user
        redirect_to main_app.root_path, notice: I18n.t('socialite.already_registered')
      end
      @user = env['omniauth.identity'] ||= Socialite.user_class.new
    end
  end
end
