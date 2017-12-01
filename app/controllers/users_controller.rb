class UsersController < ApplicationController
  before_action :signed_in?
  helper_method :own_page?

  def index
    @contacts = User.contacts(current_user)
  end

  def edit #they type 3000/add_fund
    @user = current_user
  end

  def update

  end

  def show
    @user = User.find_by(id: params[:id])
    @dealings = Dealing.where("status = ? AND (sender_id = ? OR recipient_id = ?)", "complete",  @user.id, @user.id).order(updated_at: :desc)
  end

  def signed_in?
    if !user_signed_in?
      flash[:error] = "Please sign in or sign up first."
      redirect_to new_user_session_path
    end
  end

  def own_page?
    current_user.id == @user.id
  end

  private

  def user_params

  end
end
