require 'socialite'

Socialite.setup do |config|
  ## Configure Classes
  # If you are not using the default names set below. Please change them to
  # reflect the correct classes.
  #
  # **NOTE** These _should_ be set to string values to prevent any possible
  # errors caused by load order.
  config.user_class_name = "User"
  config.identity_class_name = "Identity"

  ## Add any supported OmniAuth providers
  # You can pass any providers that are supported by OmniAuth simply by
  # including it in your Gemfile.
  #
  # Examples:
  # config.provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_SECRET'],
  #   :scope => 'email'
  # config.provider :twitter, ENV['TWITTER_APP_KEY'], ENV['TWITTER_SECRET']

  # We highly recommended adding the omniauth-identity gem to your Gemfile.
  # This does not enforce a password on signup, but establishes a common
  # 'password recovery' entry point for all users.
  #

  config.use_omniauth_identity = false
  # config.provider :identity,
  #   :model => Socialite.user_class,
  #   :fields => [:email],
  #   :on_failed_registration => Socialite::UsersController.action(:new)


  if Rails.env.production?
    # Any production specific information
  elsif Rails.env.development?
    # Configs for development mode go here
  end
end
