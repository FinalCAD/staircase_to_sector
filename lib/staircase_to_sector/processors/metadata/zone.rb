module StaircaseToSector
  module Processors
    module Metadata
      class Zone < StaircaseToSector::Processors::Base
        include StaircaseToSector::Processors::Metadata::Base

        def process(model:, context: {})
          staircase_model = model

          staircase_model.sectors.each do |_, sector_model|
            sector_model.zones.each do |_, zone_model|
              metadata = JSON.load(File.new(zone_path(zone_model)).read)

              metadata['SubView']['SectorName'] = staircase_model.name.to_s
              metadata['SubView']['ZoneName']   = "#{sector_model.name} #{zone_model.short_name}"
              metadata['SubView']['ShortName']  = "#{sector_model.name} #{zone_model.short_name}"

              file = write(%W[zone_metadata .json], metadata.to_json)
              copy(file, to_path(staircase_model, sector_model, zone_model))
            end
          end

          nil
        end

        private

        # Staircases/<Staircase Name>/Zones/<Sector Name>/<Zone Name>.json
        def zone_path(zone_model)
          # NOTE Need to move an appropriate method on file_model FileModel::Model::File
          Pathname(zone_model.source_path.to_s.gsub(/\.([\w+-]+)$/,'.json'))
        end

        # Zones\<Staircase Name>\<Sector Name> <Zone name>.json
        def to_path(staircase_model, sector_model, zone_model)
          Pathname([ export_path.to_s, 'Zones', staircase_model.name, "#{sector_model.name} #{zone_model.name}.json" ].join(File::SEPARATOR))
        end

      end
    end
  end
end
