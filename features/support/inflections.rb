module Inflections
  def pluralize(string)
    case string
    when 'expense category' then 'expense_categories'
    else "#{string}s" end
  end
end

World(Inflections)