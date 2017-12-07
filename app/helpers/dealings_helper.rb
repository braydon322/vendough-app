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

  def display_pending_tags(tags)
    if !tags.empty?
      content_tag :small, style: "color: #a8a8a8" do
        render partial: 'dealings/pending_tag', collection: tags, as: :tag
      end
    end
  end

  def display_link_tags(tags)
    if !tags.empty?
      content_tag :small, style: "color: #a8a8a8" do
        render partial: '/dealings/link_tag', collection: tags, as: :tag
      end
    end
  end

  ## wanted this helper to work, but couldn't pull it off.
  # def display_dealing_errors(dealing)
  #  if dealing.errors.any?
  #    dealing.errors.full_messages.map do |msg|
  #      #msg = "Recipient must exist"
  #      msg_arr = msg.split(" ") # [Recipient, must, exist]
  #      msg_arr[0] = "#{msg_arr[0]}:" # [Recipient:, must, exist]
  #      content_tag :li, style: "color: red" do
  #        msg_arr.join(" ")
  #      end
  #    end
  #  end
  # end


end
