require 'ostruct'

module Socialite
  class ServiceConfig < OpenStruct
    def initialize(app_key, app_secret, options)
      super({
        :app_key => app_key,
        :app_secret => app_secret,
        :options => options
      })
    end
  end
end
