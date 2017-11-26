module ApplicationHelper
  def display_credit
    sprintf("%.2f", current_user.credit)
  end

  def active?(path)
    'active' if current_page?(path)
  end
end
