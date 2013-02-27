require 'omniauth/identity/model'
require 'omniauth/identity/secure_password'

module OmniAuth
  module Identity
    module Model
      extend ActiveSupport::Concern
      # class << self
        # # alias_method :old_included, :included
        # extend ActiveSupport::Concern
      # end
    end
  end
end

module OmniAuth
  module Identity
    module SecurePassword
      extend ActiveSupport::Concern
      # class << self
        # # alias_method :old_included, :included
        # extend ActiveSupport::Concern
      # end
    end
  end
end

