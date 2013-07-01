module Socialite
  class SocialiteController < ::ActionController::Base
    layout 'socialite/socialite'

    # Override before ensure_user if it's set in the parent app's
    # ApplicationController.
    skip_before_filter :ensure_user
    #skip_before_filter :verify_authenticity_token
  end
end
