require 'ostruct'

module Socialite
  class ServiceConfig < OpenStruct
    # Set credentials and options for a given service, i.e. twitter
    def initialize(app_key, app_secret, options)
      super({
        :app_key => app_key,
        :app_secret => app_secret,
        :options => options
      })
    end
  end
end
