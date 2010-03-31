class Harvest
  class BaseModel
    
    def initialize(attributes = {})
      self.attributes = attributes
    end
    
    def attributes=(attributes)
      attributes.each {|k,v| send("#{k}=", v)}
    end
    
    def ==(other)
      id == other.id
    end
    
    def to_xml
      builder = Builder::XmlMarkup.new
      builder.tag!(self.class.tag_name) do |c|
        self.class.elements.each do |f|
          c.tag!(f.tag, send(f.name)) if send(f.name)
        end
      end
    end
  end
end