class Harvest
  class BaseApi
    def initialize(credentials)
      @credentials = credentials
    end
     
    protected
      def credentials; @credentials; end
      
      def dasherize(s)
        s.gsub("_", "-")
      end
      
      def underscore(s)
        s.gsub("-", "_")
      end
      
      def mandatory_tag(xml, tag_name, tag_value)
        xml.tag!(tag_name, tag_value)
      end
      
      def optional_tag(xml, tag_name, tag_value)
        xml.tag!(tag_name, tag_value) if tag_value
      end
  end
end