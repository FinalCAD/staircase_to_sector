module StaircaseToSector
  module Models
    class Staircase
      include Base

      attr_reader :sectors

      def initialize(*)
        super
        @sectors = {}
      end

      def name
        exploded_path.last
      end
      alias_method :full_name, :name

      def dir_path
        "Staircases#{File::SEPARATOR}#{name}"
      end

      def number_of_images
        sectors.keys.count
      end

      alias_method :full_path, :source_path

      def append_sector(sector)
        sectors[sector.name.to_s] ||= sector
      end
      alias_method :<<, :append_sector

    end
  end
end
