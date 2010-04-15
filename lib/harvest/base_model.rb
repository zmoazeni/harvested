module Harvest
  # The parent class of all Harvest models. Contains useful inheritable methods
  class BaseModel
    
    # Initializes the model. You can pass the attributes as a hash in a ActiveRecord-like style
    #
    # == Examples
    #   client = Harvest::Client.new(:name => 'John Doe')
    #   client.name # returns 'John Doe'
    def initialize(attributes = {})
      self.attributes = attributes
    end
    
    # Given a hash, sets the corresponding attributes
    #
    # == Examples
    #   client = Harvest::Client.new(:name => 'John Doe')
    #   client.name # returns 'John Doe'
    #   client.attributes = {:name => 'Terry Vaughn'}
    #   client.name # returns 'Terry Vaughn'
    #
    # @return [void]
    def attributes=(attributes)
      attributes.each {|k,v| send("#{k}=", v)}
    end
    
    # Checks the equality of another model based on the id
    #
    # == Examples
    #  client1 = Harvest::Client.new(:id => 1)
    #  client2 = Harvest::Client.new(:id => 1)
    #  client3 = Harvest::Client.new(:id => 2)
    #  
    #  client1 == client2 # returns true
    #  client1 == client3 # returns false
    #
    # @return [Boolean]
    def ==(other)
      id == other.id
    end
    
    # Returns the id of the model
    #
    # == Examples
    #  client = Harvest::Client.new(:id => 1)
    #  client.to_i # returns 1
    #
    # @return [Fixnum]
    def to_i
      id
    end
    
    # Builds the XML of the model. Primarily used to interact with the Harvest API.
    # 
    # @return [String]
    def to_xml
      builder = Builder::XmlMarkup.new
      builder.tag!(self.class.tag_name) do |c|
        self.class.elements.each do |f|
          c.tag!(f.tag, send(f.name)) if send(f.name)
        end
      end
    end
  
    class << self
      # This sets the API path so the API collections can use them in an agnostic way
      # @return [void]
      def api_path(path = nil)
        @path ||= path
      end
    end
  end
end