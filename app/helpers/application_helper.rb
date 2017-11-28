module ApplicationHelper
  def display_credit
    sprintf("%.2f", current_user.credit)
  end

  def incomplete_count
    current_user.requests_awaiting_approval_by_others.count unless
    current_user.requests_awaiting_approval_by_others.empty?
  end

  def requests_count
    current_user.requests_for_money_from_others.count unless
    current_user.requests_for_money_from_others.empty?
  end

  def active?(path)
    'active' if current_page?(path)
  end

  def format_with_color(transaction)
    if transaction.sender == current_user
      "color: red; position: absolute; bottom: 20px; right: 10px; width: 150px; text-align:right;"
    else
      "color: green; position: absolute; bottom: 20px; right: 10px; width: 150px; text-align:right;"
    end
  end

  def plus_or_minus(transaction)
    if transaction.sender == current_user
      "- "
    else
      "+ "
    end
  end

  def current_user_involved?(transaction)
    transaction.sender == current_user || transaction.recipient == current_user
  end
end
