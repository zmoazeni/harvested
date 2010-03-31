module Inflections
  def pluralize(string)
    case string
    when 'person' then 'people'
    else "#{string}s"
    end
  end
end

World(Inflections)