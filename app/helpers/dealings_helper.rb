module DealingsHelper

  def cost_involved(dealing)
    if current_user_involved?(dealing)
      content_tag :div, style: format_with_color(dealing) do
        bottom_line(dealing)
      end
    end
  end

  def bottom_line(dealing)
    "#{plus_or_minus(dealing)}#{number_to_currency(dealing.amount)}"
  end

  def plus_or_minus(dealing)
    if dealing.sender == current_user && dealing.action == "request" || dealing.recipient == current_user && dealing.action == "pay"
      "+ "
    else
      "- "
    end
  end

  def format_with_color(dealing)
    if dealing.sender == current_user && dealing.action == "request" || dealing.recipient == current_user && dealing.action == "pay"
      "color: green; position: absolute; bottom: 48px; right: 15px; width: 150px; text-align:right;"
    else
      "color: red; position: absolute; bottom: 48px; right: 15px; width: 150px; text-align:right;"
    end
  end

  def place_top_right
    "position: absolute; top: 10px; right: 15px; width: 90px; text-align:right;"
  end

  def long_rectangular_block
    "btn btn-sm btn-default btn-block"
  end

  def current_user_involved?(dealing)
    dealing.sender == current_user || dealing.recipient == current_user
  end

  def charged_or_paid(dealing)
    dealing.action == "request" ? "charged" : "paid"
  end

end
