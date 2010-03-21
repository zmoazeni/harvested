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
      builder.tag!(xml_name) do |c|
        self.class.elements.each do |f|
          c.tag!(f.tag, send(f.name)) if send(f.name)
        end
      end
    end
    
    def xml_name
      self.class.instance_variable_get("@name")
    end
    
    class << self
      def xml_name(name)
        @name = name
      end
    end
  end
end