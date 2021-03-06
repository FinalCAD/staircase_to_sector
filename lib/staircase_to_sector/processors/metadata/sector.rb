# Public: Staircase Metadata computation
#
module StaircaseToSector
  module Processors
    module Metadata
      class Sector < StaircaseToSector::Processors::Base
        include StaircaseToSector::Processors::Metadata::Base

        def process(model:, context: {})
          super # Trigger calculation

          staircase_model = model
          # NOTE The template can be extracted to an .example file
          metadata = metadata_template

          metadata[:Sector][:SectorName] = staircase_model.name.to_s

          tags = []
          staircase_model.sectors.each do |_, sector_model|
            sector_metadata = JSON.load(File.new(sector_path(sector_model)).read)
            tags << Array(sector_metadata[:Tags])

            cell = grid.move # Move on the next cell of the grid (matrix)
            # Give the StaircaseToSector::Lib::Point of the coordinate on the top, left of the image
            position = sector_position.coordinate(column: cell.column.to_i, row: cell.row.to_i)

            sector_model.zones.each do |_, zone_model|
              zone_metadata = zone_metadata(sector_metadata, zone_model.short_name.to_s)

              updater = StaircaseToSector::Metadata::TextPosition.new(
                metadata:         zone_metadata,
                layout_dimension: layout_dimension,
                image_dimension:  size.image_dimension)

              text_position_keys.each do |keys|
                updater.update!(position: position, keys: keys)
              end

              updater = StaircaseToSector::Metadata::Polyline.new(
                metadata:         zone_metadata,
                layout_dimension: layout_dimension,
                image_dimension:  size.image_dimension)

              polyline_keys.each do |keys|
                updater.update!(position: position, keys: keys)
              end

              updater.metadata['ZoneName']  = "#{sector_model.name} #{zone_model.short_name}"
              updater.metadata['ShortName'] = "#{sector_model.name} #{zone_model.short_name}"

              metadata[:Sector][:Zones] << updater.metadata
            end
          end

          metadata[:Sector][:Tags] = tags.flatten.compact.uniq.sort

          file = write(%W[sector_metadata .json], metadata.to_json)
          copy(file, to_path(staircase_model))

          nil
        end

        private

        # NOTE Can be extracted to an .example file
        def text_position_keys
          [
            [ :TextPosition,    :Latitude  ],
            [ :TextPosition,    :Longitude ],
            [ :TextPositionBRC, :Latitude  ],
            [ :TextPositionBRC, :Longitude ],
            [ :TextPositionULC, :Latitude  ],
            [ :TextPositionULC, :Longitude ],
          ]
        end

        # NOTE Can be extracted to an .example file
        def polyline_keys
          [[ :Polyline, :coordinates ]]
        end

        # Private: Return the computed target path
        #
        # sector_model - The instance model of StaircaseToSector::Models::Sector
        #
        # Examples
        #
        #   Staircases/<Staircase Name>/Sectors/<Sector Name>.json
        #
        # Returns a Pathname
        def sector_path(sector_model)
          # NOTE Need to move an appropriate method on file_model FileModel::Model::File
          Pathname(sector_model.source_path.to_s.gsub(/\.([\w+-]+)$/,'.json'))
        end

        # Private: Return the computed target path
        #
        # staircase_model - The instance model of StaircaseToSector::Models::Staircase
        #
        # Examples
        #
        #   Sectors/<Staircase Name>.json
        #
        # Returns a Pathname
        def to_path(staircase_model)
          Pathname([ export_path.to_s, 'Sectors', "#{staircase_model.name}.json" ].join(File::SEPARATOR))
        end

        def metadata_template
          {
            "Sector": {
              "Zones": [],
              "Tags": [],
              "WidthMeters": nil,
              "AngleWithNorth": 0,
              "SectorName": nil,
              "HasValidNorth": false
            }
          }
        end

        # Private: Return part corresponding of the current zone
        #
        # sector_metadata - The Hash, Sector Metadata
        # zone_name - The String, name of the Zone
        #
        # Returns a Hash
        def zone_metadata(sector_metadata, zone_name)
          sector_metadata['Sector']['Zones'].detect { |zone| zone['ZoneName'] == zone_name }
        end

      end
    end
  end
end
