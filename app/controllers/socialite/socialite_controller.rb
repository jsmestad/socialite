module Socialite
  class SocialiteController < ::ApplicationController
    layout 'socialite/socialite'

    # Override before ensure_user if it's set in the parent app's
    # ApplicationController.
    skip_before_filter :ensure_user
  end
end
