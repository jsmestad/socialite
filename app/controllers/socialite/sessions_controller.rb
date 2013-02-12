module Socialite
  class SessionsController < ApplicationController
    unloadable

    def new
      # Login Page
    end

    def create
      auth = request.env['omniauth.auth']
      # Find an identity here
      @identity = Socialite.identity_class.find_or_create_from_omniauth(auth)

      if user_signed_in? # Check if user is already signed in.
        if @identity.user == current_user
          # User is signed in so they are trying to link an identity with their
          # account. But we found the identity and the user associated with it
          # is the current user. So the identity is already associated with
          # this user. So let's display an error message.
          redirect_to main_app.root_url, :notice => "You have already linked this account"
        else
          # The identity is not associated with the current_user so lets
          # associate the identity.
          @identity.user = current_user
          @identity.save
          redirect_to main_app.root_url, :notice => "Account successfully authenticated"
        end
      else # User is not logged in, this is a new signin
        if @identity.user.present?
          # The identity we found had a user associated with it so let's
          # just log them in here
          self.current_user = @identity.user
          redirect_to main_app.root_url, :notice => "Signed in!"
        else
          # The authentication has no user assigned and there is no user signed in
          # Our decision here is to create a new account for the user
          # But your app may do something different (eg. ask the user
          # if he already signed up with some other service)
          user = if @identity.provider == 'identity'
                   Socialite.user_class.find(@identity.uid)
                   # If the provider is identity, then it means we already created a user
                   # So we just load it up
                 else
                   # otherwise we have to create a user with the auth hash
                   Socialite.user_class.create_from_omniauth(auth)
                   # NOTE: we will handle the different types of data we get back
                   # from providers at the model level in create_from_omniauth
                 end
          # We can now link the authentication with the user and log him in
          user.identities << @identity
          self.current_user = user
          redirect_to main_app.root_path, notice: "Welcome to The app!"

          # No user associated with the identity so we need to create a new one
          # redirect_to new_user_url, :notice => "Please finish registering"
        end
      end
    end

    def destroy
      self.current_user = nil
      redirect_to main_app.root_url, :notice => 'Signed out!'
    end

    def failure
      redirect_to main_app.root_url, :alert => "Authentication failed, please try again."
    end
  end
end
