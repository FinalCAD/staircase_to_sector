module StaircaseToSector
  module Processors
    class Base
      include FileModel::Processor::Base

      def initialize(*)
        super
        @layout_dimension = Lib::Dimension.new(width: StaircaseToSector.configuration.layout[:dimension][:width], height: StaircaseToSector.configuration.layout[:dimension][:height])
        @marge            = Lib::Dimension.new(height: StaircaseToSector.configuration.layout[:marge][:height], width: StaircaseToSector.configuration.layout[:marge][:width])
      end

      def process(model:, context: {})
        context = context.merge(options)

        @number_of_images = model.number_of_images
        @grid             = Lib::Grid.new(number_of_images)
        @size             = Lib::Size.new(grid: grid, layout_dimension: layout_dimension, marge: StaircaseToSector.configuration.layout[:marge][:width]).call
        @sector_position  = Lib::SectorPosition.new(dimension: size.image_dimension, marge: marge, footer: StaircaseToSector.configuration.layout[:footer])
        @text_position    = Lib::TextPosition.new(pointsize: StaircaseToSector.configuration.layout[:pointsize], image_dimension: size.image_dimension, layout_dimension: layout_dimension)
      end

      protected

      def escaped(path)
        Pathname(path.to_s.gsub(/ /,'\ '))
      end

      attr_reader :number_of_images, :marge, :grid, :size, :sector_position, :text_position, :layout_dimension

      def layout_path(model)
        export_path + 'Sectors' + Pathname(model.name.to_s + '.png')
      end

    end
  end
end
