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
    @transaction.status = "sending"
    @transaction.pay_transaction
    @transaction.save
    redirect_to root_path
  end

  def ask
    # binding.pry
    @transaction = Transaction.new(transaction_params)
    @transaction.status = "incomplete"
    @transaction.save
    recipient = User.find_by(id: @transaction.recipient_id)
    flash[:message] = "Your request to #{recipient.name} has been sent."
    redirect_to root_path
  end

  def show
  end

  def incomplete
  end

  private

  # def set_attraction
  #   @attraction = Attraction.find_by(id: params[:id])
  # end

  def transaction_params
    params.require(:transaction).permit(:sender_id, :recipient_id, :amount, :description)
  end

end
