# Public: Base Staircase model based on FileModel::Model::File
#
module StaircaseToSector
  module Models
    module Base
      extend ActiveSupport::Concern
      include FileModel::Model::File

      # Public: Return if the model should be ignored
      #
      # In The Staircase every files and directories need to be taken into account
      #
      # Returns a Boolean
      def skip?
        !model.source_path.match(/Staircases/)
      end
    end
  end
end
