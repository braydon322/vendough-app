class DealingsController < ApplicationController

  def index
  end

  def new
    @dealing = Dealing.new
  end

  def create
    binding.pry
    @dealing = Dealing.new(dealing_params)
    if @dealing.action == "request"
      @dealing.status = "incomplete"
      @dealing.save
      flash[:message] = "Your request to #{@dealing.recipient.name} has been sent."
      redirect_to root_path
    elsif @dealing.action == "pay"
      binding.pry
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
    flash[:message] = "You have successfully approved request from #{@dealing.recipient.name}."
    redirect_back(fallback_location: root_path)
  end

  def requests
    @requests = current_user.requests_for_money_from_others
  end

  def incomplete
    @dealings = current_user.requests_awaiting_approval_by_others
  end

  def show
  end

  def destroy
    @dealing = Dealing.find(params[:id])
    @dealing.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def dealing_params
    params.require(:dealing).permit(:sender_id, :recipient_id, :amount, :description, :action, :tags_attributes => [:name])
  end

end
