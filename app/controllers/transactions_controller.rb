class TransactionsController < ApplicationController

  def index
  end

  def new
    @transaction = Transaction.new
  end

  def create
  end

  def pay
    binding.pry
  end

  def ask
    binding.pry
  end

  def show
  end

end
