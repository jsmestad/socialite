module Socialite
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper_method :current_user, :user_signed_in?
      end

      def current_user
        @current_user ||= if session.has_key?(:user_id)
                            Socialite.user_class.find(session[:user_id])
                          end
      rescue ActiveRecord::RecordNotFound
        session[:user_id] = nil
      end

      def ensure_user
        if defined?(super)
          super
        else
          unless user_signed_in?
            redirect_to login_path, :alert => I18n.t('socialite.login_required')
          end
        end
      end

      def logout!
        self.current_user = nil and session.destroy
      end

      def user_signed_in?
        !!current_user
      end

      def current_user=(user)
        @current_user = user
        session[:user_id] = user.nil? ? user : user.id
      end

      def after_link_path
        main_app.root_path
      end

      def after_signup_path
        main_app.root_path
      end

      def after_failure_path
        main_app.root_path
      end

      def after_login_path
        main_app.root_path
      end

      def after_logout_path
        main_app.root_path
      end
    end
  end
end
