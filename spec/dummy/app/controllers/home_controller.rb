class HomeController < ApplicationController
  before_filter :ensure_user, :only => [:show]

  def index
    render
  end

  def show
    render
  end
end
