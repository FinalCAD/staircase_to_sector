module StaircaseToSector
  module Processors
    module Metadata
      module Base
        extend ActiveSupport::Concern

        private

        def write(name, content)
          file = Tempfile.new(name)
          file.write(content)
          file.rewind
          file
        end

      end
    end
  end
end
