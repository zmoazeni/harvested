class Harvest
  class BaseModel
    
    def initialize(attributes = {})
      attributes.each {|k,v| send("#{k}=", v)}
    end
    
    def ==(other)
      id == other.id
    end
  end
end