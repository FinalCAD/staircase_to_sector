module StaircaseToSector
  module Lib
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Point
      autoload :Cursor
      autoload :Dimension
      autoload :Grid
      autoload :SectorPosition
      autoload :TextPosition
      autoload :Size
    end
  end
end
