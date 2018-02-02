module StaircaseToSector
  module Models
    module Base
      extend ActiveSupport::Concern
      include FileModel::Model::File

      def skip?
        !(extension.to_s =~ /\.png$|\.json$/)
      end
    end
  end
end
