require 'koala'

module Socialite
  class FacebookIdentity < ActiveRecord::Base
    include Identity

    class << self
      def lookup(unique_id, options={})
        options.reverse_merge!({:access_token => nil})
        api_connection(options[:access_token]).get_object(unique_id)
      end

      def api_connection(access_token=nil)
        Koala::Facebook::API.new(access_token)
      end
    end

    def account_url
      "http://facebook.com/#{self.login}"
    end

    def api
      api_connection
    end

    def checkins
      api.get_connections(unique_id, 'checkins')
    end

    def friends
      api.get_connections(unique_id, 'friends')
    end

    def picture
      api.get_picture(unique_id)
    end

    def info
      api.get_object(unique_id)
    end

  protected

    def api_connection
      @api_connection ||= self.class.api_connection(access_token)
    end
  end
end
