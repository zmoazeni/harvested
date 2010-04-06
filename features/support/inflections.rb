module Inflections
  def pluralize(string)
    "#{string}s"
  end
end

World(Inflections)