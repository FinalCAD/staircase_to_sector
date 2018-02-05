module StaircaseToSector
  module Processors
    class ComposeGrid < StaircaseToSector::Processors::Base

      def process(model:, context: {})
        super

        staircase_model = model
        staircase_model.sectors.each do |_, sector_model|
          cmd = []

          cell = grid.move
          position = sector_position.coordinate(column: cell.column.to_i, row: cell.row.to_i)

          file_to_compose_path = escaped(compose_path(sector_model))

          cmd << "composite -geometry #{size}#{position} #{file_to_compose_path}"

          cmd << escaped(layout_path(staircase_model))
          cmd << escaped(layout_path(staircase_model))

          run_command(cmd.join(' '))
        end

        nil
      end

      private

      # Returns an Pathname
      def compose_path(sector_model)
        # NOTE Need to move an appropriate method on file_model FileModel::Model::File
        Pathname(sector_model.source_path.to_s.gsub(/\.([\w+-]+)$/,'.png'))
      end

    end
  end
end
