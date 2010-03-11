class Harvest
  module Models
    class Base
      def ==(other)
        id == other.id
      end
    end
  end
end