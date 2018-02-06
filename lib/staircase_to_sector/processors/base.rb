# Public: Based on FileModel::Processor::Base
#
module StaircaseToSector
  module Processors
    class Base
      include FileModel::Processor::Base

      # Public: Based on FileModel::Processor::Base
      #
      # Take the options of Hash of FileModel::Processor::Base
      # options - The Hash of options, NOTE if the options do have the export_path: 'path' some processor might fail
      #
      # set the common libraries for all the sub-processes
      #
      # Returns a instance of Processor
      def initialize(*)
        super
        @layout_dimension = Lib::Dimension.new(width: StaircaseToSector.configuration.layout[:dimension][:width], height: StaircaseToSector.configuration.layout[:dimension][:height])
        @marge            = Lib::Dimension.new(height: StaircaseToSector.configuration.layout[:marge][:height], width: StaircaseToSector.configuration.layout[:marge][:width])
      end

      # Public: Based on FileModel::Processor::Base#process
      #
      # model - The instance model of FileModel::Model::Base
      # context - The Hash of options, NOTE it will override global options
      #
      # set the libraries concerning the current model for the sub-processes
      #
      # Returns nothing
      def process(model:, context: {})
        context = context.merge(options)

        @number_of_images = model.number_of_images
        @grid             = Lib::Grid.new(number_of_images)
        @size             = Lib::Size.new(grid: grid, layout_dimension: layout_dimension, marge: StaircaseToSector.configuration.layout[:marge][:width]).call
        @sector_position  = Lib::SectorPosition.new(dimension: size.image_dimension, marge: marge, footer: StaircaseToSector.configuration.layout[:footer])
        @text_position    = Lib::TextPosition.new(pointsize: StaircaseToSector.configuration.layout[:pointsize], image_dimension: size.image_dimension, layout_dimension: layout_dimension)

        nil
      end

      protected

      # Protected: Escape URL
      #
      # path - The path of the file
      #
      # Imagemagick doesn't handle well space on the path
      #
      # Returns escaped path
      def escaped(path)
        Pathname(path.to_s.gsub(/ /,'\ '))
      end

      attr_reader :number_of_images, :marge, :grid, :size, :sector_position, :text_position, :layout_dimension

      # Protected: Get Layout Path
      #
      # model - The instance model of StaircaseToSector::Models::Staircase
      #
      # The path is the same for one Staircase
      #
      # Returns Target Staircase Path
      def layout_path(model)
        export_path + 'Sectors' + Pathname(model.name.to_s + '.png')
      end

    end
  end
end
