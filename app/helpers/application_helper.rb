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

  def format_with_color(dealing)
    if dealing.sender == current_user && dealing.amount > 0 || dealing.recipient == current_user && dealing.amount < 0
      "color: green; position: absolute; bottom: 48px; right: 15px; width: 150px; text-align:right;"
    else
      "color: red; position: absolute; bottom: 48px; right: 15px; width: 150px; text-align:right;"
    end
  end

  def plus_or_minus(dealing)
    if dealing.sender == current_user && dealing.amount > 0 || dealing.recipient == current_user && dealing.amount < 0
      "+ "
    else
      "- "
    end
  end

  def current_user_involved?(dealing)
    dealing.sender == current_user || dealing.recipient == current_user
  end

end
