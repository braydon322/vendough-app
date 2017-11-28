class UsersController < ApplicationController
  before_action :signed_in?

  def show
    @user = User.find_by(id: params[:id])
    @transactions = Transaction.where("sender_id = ? OR recipient_id = ?", @user.id, @user.id).order(updated_at: :desc)
  end

  def signed_in?
    if !user_signed_in?
      flash[:error] = "Please sign in or sign up first."
      redirect_to new_user_session_path
    end
  end
end
