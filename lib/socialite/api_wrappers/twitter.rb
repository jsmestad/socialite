module Socialite
  module ApiWrappers
    module Twitter
      extend ActiveSupport::Concern

      included do
        require 'twitter'
      end

      module ClassMethods

      end

      module InstanceMethods

      end
    end
  end
end
