module Socialite
  module Helpers
    module Authentication
      def identity_request_path(options={})
        ['/auth', options[:service]].join('/')
      end

      def twitter_login_button
        content_tag(:a, content_tag(:span, 'Sign in with Twitter'), :class => 'socialite_button twitter', :href => identity_request_path(:service => 'twitter'), :rel => 'external')
      end

      def facebook_login_button
        content_tag(:a, content_tag(:span, 'Sign in with Facebook'), :class => 'socialite_button facebook', :href => identity_request_path(:service => 'facebook'), :rel => 'external')
      end
    end
  end
end
