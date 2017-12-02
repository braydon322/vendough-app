module ApplicationHelper
  # def credit_logic
  #   if current_user.credit
  #   sprintf("%.2f", number_to_currency(current_user.credit))
  # end
  def display_credit
    number_to_currency(User.find(current_user.id).credit)
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

end
