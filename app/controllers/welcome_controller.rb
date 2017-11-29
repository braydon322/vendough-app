class WelcomeController < ApplicationController
  before_action :signed_in?


  def home
    @dealings = Dealing.newest_first
  end

  def signed_in?
    if !user_signed_in?
      flash[:error] = "Please sign in or sign up first."
      redirect_to new_user_session_path
    end
  end
end
