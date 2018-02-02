module StaircaseToSector
  module Lib
    class Dimension

      def initialize(height:, width:)
        @height, @width = height, width
      end

      def height
        @height.to_f
      end
      alias_method :y, :height

      def width
        @width.to_f
      end
      alias_method :x, :width

      def to_s
        "#{width}x#{height}"
      end

      def ratio
        (width / height).round(2)
      end
    end
  end
end
