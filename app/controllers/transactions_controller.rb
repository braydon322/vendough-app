class TransactionsController < ApplicationController
  # before_action :set_attraction, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.action == "request"
      @transaction.status = "incomplete"
      @transaction.save
      flash[:message] = "Your request to #{@transaction.recipient.name} has been sent."
      redirect_to root_path
    elsif @transaction.action == "pay"
      @transaction.pay_transaction
      @transaction.save
      flash[:message] = "You have successfully sent money to #{@transaction.recipient.name}."
      redirect_to root_path
    end
  end

  def update #i.e. approving transaction
    @transaction = current_user.requests_for_money_from_others.find_by(id: params[:transaction][:id])
    @transaction.approve_transaction
    @transaction.save
    flash[:message] = "You have successfully approved request from #{@transaction.recipient.name}."
    redirect_back(fallback_location: root_path)
  end

  def requests
    @requests = current_user.requests_for_money_from_others
  end

  def incomplete
    @transactions = current_user.requests_awaiting_approval_by_others
  end

  def show
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  # def set_attraction
  #   @attraction = Attraction.find_by(id: params[:id])
  # end

  def transaction_params
    params.require(:transaction).permit(:sender_id, :recipient_id, :amount, :description, :action)
  end

end
