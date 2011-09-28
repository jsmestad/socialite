module Socialite
  class SessionController < ApplicationController
    unloadable

    before_filter :ensure_user, :only => [:destroy]
    before_filter :ensure_no_user, :except => [:destroy]

    respond_to :html, :json


  end
end
