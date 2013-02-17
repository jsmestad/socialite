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
            redirect_to login_path, :alert => 'You must be logged in to use this feature.'
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
    end
  end
end
