class ActionController::Base
  def self.require_user(options = {})
    if self == ActionController::Base
      raise Exception, "require_user cannot be called on ActionController::Base. Only it's subclasses"
    end
    prepend_before_filter :require_user, options
  end

  helper_method :current_user, :user_signed_in?, :current_user?

protected

  # Filters

  # Conditional check to see if a current user exists
  #
  # @return [Boolean]
  def require_user
    current_user.present? || deny_access
  end

  # Utils

  # Store the location URL in the session for later use.
  #
  # @return [Hash] the modified session object
  def store_location
    session[:return_to] = request.fullpath
  end

  # Stores the URL for the current requested action, then redirects to
  # the login page.
  #
  # @note This method sets the redirect path, but does not return false.
  # Meaning you can perform actions after this method is invoked.
  def deny_access
    store_location
    redirect_to login_path
  end

  # Conditional redirect to handle an empty return_to path. If return_to
  # is empty, the request is redirected to the default path
  #
  # @param [String] path to use as the default redirect location
  # @return [Hash] the modified session hash
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  # Fetch the User model associated with the current session.
  #
  # @return [User]
  # (see #current_user=)
  def current_user
    @current_user ||= if session[:user_id]
      User.find(session[:user_id])
    elsif cookies[:remember_token]
      User.find_by_remember_token(cookies[:remember_token])
    end
  end

  # Assign the User model associated with the current session.
  #
  # @return [User]
  # (see #current_user)
  def current_user=(user)
    user.tap do |user|
      user.remember
      session[:user_id]         = user.id
      cookies[:remember_token]  = user.remember_token
    end
  end

  # Accessor method for checking if a user is currently signed in
  #
  # @return [Boolean]
  # (see #current_user)
  def user_signed_in?
    !!current_user
  end
  alias_method :current_user?, :user_signed_in?

  # Destroy the current user session, effectively logging them out upon
  # the next request.
  #
  # @return [Hash] the modified session object
  def logout!
    session[:user_id] = nil
    @current_user     = nil
    cookies.delete(:remember_token)
    session[:return_to] = nil
  end

end
