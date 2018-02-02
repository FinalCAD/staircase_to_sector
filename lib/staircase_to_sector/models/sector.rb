module StaircaseToSector
  module Models
    class Sector
      include Base

      attr_reader :zones

      def initialize(*)
        super
        @zones = {}
      end

      def append_zone(zone)
        zones[zone.name.to_s] ||= zone
      end
      alias_method :<<, :append_zone
    end
  end
end
