module StaircaseToSector
  module Models
    module Base
      extend ActiveSupport::Concern
      include FileModel::Model::File

      # StaircaseToSector::Feeder need all files, including directories
      def skip?
        # !(extension.to_s =~ /\.png$|\.json$/)
      end
    end
  end
end
