module StaircaseToSector
  module Processors
    class Annotate < StaircaseToSector::Processors::Base

      def process(model:, context: {})
        super

        staircase_model = model
        staircase_model.sectors.each do |_, sector_model|
          cell = grid.move
          image_position = sector_position.coordinate(column: cell.column.to_i, row: cell.row.to_i)

          cmd = [
            'convert',
            escaped(layout_path(staircase_model)),
            '-fill "#071D49"',
            "-pointsize #{text_position.pointsize}",
            '-gravity Center',
            "-annotate #{text_position.coordinate(image_position)}",
            "\"#{sector_model.name}\"",
            escaped(layout_path(staircase_model))
          ]

          run_command(cmd.join(' '))
        end

        nil
      end

    end
  end
end
