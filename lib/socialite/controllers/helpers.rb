module Socialite
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper_method :current_user, :user_signed_in?
      end

      def current_user
        @current_user ||= User.find_by_id(session[:user_id])
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
