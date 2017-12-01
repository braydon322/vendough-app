class DealingsController < ApplicationController
  before_action :signed_in?
  def index
    @dealings = Dealing.newest_first
  end

  def new
    @dealing = Dealing.new
    if params[:user_id]
      @preselected_user = params[:user_id]
    end
  end

  def create
    @dealing = Dealing.new(dealing_params)
    if @dealing.action == "request"
      @dealing.status = "incomplete"
      @dealing.save
      flash[:message] = "Your request to #{@dealing.recipient.name} has been sent."
      redirect_to root_path
    elsif @dealing.action == "pay"
      @dealing.pay_dealing
      if @dealing.sender.save
        @dealing.recipient.save
        @dealing.save
        flash[:message] = "You have successfully sent money to #{@dealing.recipient.name}."
        redirect_to root_path
      else
        flash[:message] = @dealing.sender.errors[:credit].first
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def update #i.e. approving dealing
    @dealing = current_user.requests_for_money_from_others.find_by(id: params[:dealing][:id])
    @dealing.approve_dealing
    @dealing.save
    flash[:message] = "You have successfully approved request from #{@dealing.sender.name}."
    redirect_back(fallback_location: root_path)
  end

  def requests
    @requests = current_user.requests_for_money_from_others
  end

  def incomplete
    @dealings = current_user.requests_awaiting_approval_by_others
  end

  def show
    @dealing = Dealing.find(params[:id])
  end

  def destroy
    @dealing = Dealing.find(params[:id])
    @dealing.destroy
    redirect_back(fallback_location: root_path)
  end

  def signed_in?
    if !user_signed_in?
      flash[:error] = "Please sign in or sign up first."
      redirect_to new_user_session_path
    end
  end
  private

  def dealing_params
    params.require(:dealing).permit(:sender_id, :recipient_id, :amount, :description, :action, :tags_attributes => [:name])
  end

end
