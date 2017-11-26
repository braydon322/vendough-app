module TransactionsHelper
  def incomplete_count
    Transaction.incomplete(current_user).count unless Transaction.incomplete(current_user).empty?
  end
end
