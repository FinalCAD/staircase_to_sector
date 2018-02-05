module StaircaseToSector
  module Processors
    extend ActiveSupport::Autoload

    autoload :StaircaseComposer

    eager_autoload do
      autoload :Base
      autoload :Annotate
      autoload :ComposeGrid
      autoload :CreateLayout
      autoload :MoveZone
      autoload :Metadata
    end
  end
end
