# frozen_string_literal: true

module HomeHelper
  def format_date(date)
    date.strftime('%B %d, %Y')
  end
end
