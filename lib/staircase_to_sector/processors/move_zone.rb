module StaircaseToSector
  module Processors
    class MoveZone < StaircaseToSector::Processors::Base

      def process(model:, context: {})
        staircase_model = model
        staircase_model.sectors.each do |_, sector_model|
          sector_model.zones.each do |_, zone_model|
            copy(from_path(zone_model), to_path(staircase_model, sector_model, zone_model))
          end
        end
      end

      private

      # Staircases/<Staircase Name>/Zones/<Sector Name>/<Zone Name>.png
      def from_path(zone_model)
        # NOTE Need to move an appropriate method on file_model FileModel::Model::File
        Pathname(zone_model.source_path.to_s.gsub(/\.([\w+-]+)$/,'.png'))
      end

      # Zones\<Staircase Name>\<Sector Name> <Zone name>.png
      def to_path(staircase_model, sector_model, zone_model)
        Pathname([ export_path.to_s, 'Zones', staircase_model.name, "#{sector_model.name} #{zone_model.name}.png" ].join(File::SEPARATOR))
      end
    end
  end
end
