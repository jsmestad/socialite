module Socialite
  module AuthHelper
    def auth_request_path(options = {})
      "/auth/#{options[:service]}"
    end

    def twitter_login_button
      content_tag(:a, content_tag(:span, 'Sign in with Twitter'), :class => 'socialite-button twitter', :href => auth_request_path(:service => 'twitter'), :rel => 'external')
    end

    def facebook_login_button
      content_tag(:a, content_tag(:span, 'Sign in with Facebook'), :class => 'socialite-button facebook', :href => auth_request_path(:service => 'facebook'), :rel => 'external')
    end

    def linkedin_login_button
      content_tag(:a, content_tag(:span, 'Sign in with LinkedIn'), :class => 'socialite-button linkedin', :href => auth_request_path(:service => 'linked_in'), :rel => 'external')
    end

    def github_login_button
      content_tag(:a, content_tag(:span, 'Sign in with Github'), :class => 'socialite-button github', :href => auth_request_path(:service => 'github'), :rel => 'external')
    end
  end
end
