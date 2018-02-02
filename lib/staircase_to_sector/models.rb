module StaircaseToSector
  module Models
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base
      autoload :Zone
      autoload :Sector
      autoload :Staircase
    end
  end
end
