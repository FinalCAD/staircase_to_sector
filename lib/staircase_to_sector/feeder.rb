module StaircaseToSector
  module Feeder

    attr_reader :store, :staircase_name, :sector_name, :zone_name

    def initialize(store)
      @store = store
    end

    def append(model)
      type = ModelType.new(model)
      name = ModelName.new(model)

      return false if type.skip? # A/Path/Staircases

       # A/Path/Staircases/<Staircase Name>/Zones/<Sector Name>/<Zone Name>.<extension>
      if type.zone?
        name = ZoneModelName.new(model)
        sector_name = name.sector_name
        @zone_name = name.filename

        zone = Models::Zone.new(model.source_path)
        sector = store.models[staircase_name].sectors[sector_name]
        sector << zone
        return true
      end

       # A/Path/Staircases/<Staircase Name>/Sectors/<Sector Name>.<extension>
      if type.sector?
        @sector_name = name.filename
        sector = Models::Sector.new(model.source_path)
        store.models[staircase_name] << sector
        return true
      end

      if type.staircase? # A/Path/Staircases/<Staircase Name>
        @staircase_name = name.filename
        staircase = Models::Staircase.new(model.source_path)
        store << staircase
        return true
      end
    end
    alias_method :<<, :append

    class ModelName

      def initialize(model)
        @model = model
      end

      def filename
        model.exploded_path.last.split('.').first
      end

      private

      attr_reader :model
    end

    class ZoneModelName < ModelName

      def sector_name
        model.exploded_path[0..-2].last
      end
    end

    class ModelType

      def initialize(model)
        @model = model
      end

      def skip?
        shadow_zone? || shadow_sector_zone? || shadow_sector? || (!zone? && !sector? && !staircase?)
      end

      def staircase?
        return false if zone?
        return false if sector?
        model.source_path.to_s =~ /Staircases\// && !file?
      end

      def shadow_sector?
        model.source_path.to_s =~ /Sectors/ && !file?
      end

      def sector?
        return false if zone?
        model.source_path.to_s =~ /Sectors\// && file?
      end

      def shadow_sector_zone?
        model.source_path.to_s =~ /Zones\// && !file?
      end

      def shadow_zone?
        model.source_path.to_s =~ /Zones/ && !file?
      end

      def zone?
        model.source_path.to_s =~ /Zones\// && file?
      end

      def file?
        !File.directory?(model.source_path.to_s)
      end

      private

      attr_reader :model
    end
  end
end
