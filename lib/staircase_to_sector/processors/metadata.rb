module StaircaseToSector
  module Processors
    module Metadata
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :Base
        autoload :Sector
        autoload :Zone
      end
    end
  end
end
