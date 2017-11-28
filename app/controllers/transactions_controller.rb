class TransactionsController < ApplicationController
  # before_action :set_attraction, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @transaction = Transaction.new
  end

  def create
  end

  def pay
    @transaction = Transaction.new(transaction_params)
    @transaction.pay_transaction
    @transaction.save
    redirect_to root_path
  end

  def ask
    @transaction = Transaction.new(transaction_params)
    @transaction.status = "incomplete"
    @transaction.save
    flash[:message] = "Your request to #{@transaction.recipient.name} has been sent."
    redirect_to root_path
  end

  def requests
    @requests = current_user.requests_for_money_from_others
  end

  def approve
    @transaction = current_user.requests_for_money_from_others.find_by(id: params[:transaction][:id])
    @transaction.approve_transaction
    @transaction.save
    redirect_back(fallback_location: root_path)
  end

  def show
  end

  def incomplete
    @transactions = current_user.requests_awaiting_approval_by_others
  end

  def destroy
    binding.pry
    @transaction = current_user.transactions.find_by(id: params[:id])
    @transaction.destroy
    flash[:message] = "Your request has been cancelled."
    redirect_back(fallback_location: root_path)
  end

  private

  # def set_attraction
  #   @attraction = Attraction.find_by(id: params[:id])
  # end

  def transaction_params
    params.require(:transaction).permit(:sender_id, :recipient_id, :amount, :description)
  end

end
