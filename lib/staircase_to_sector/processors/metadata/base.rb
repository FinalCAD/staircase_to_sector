# Public: Give common methods of Metadata computation
#
module StaircaseToSector
  module Processors
    module Metadata
      module Base
        extend ActiveSupport::Concern

        private

        # Private: Return the computed source path
        #
        # name - The String, name of the Tempfile
        # content - The String of the content to write
        #
        # Examples
        #
        #   write(%W[file .txt], 'Bla Bla Bla')
        #   # => #<Tempfile:/a/path/file.txt
        #
        # Returns a Tempfile
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
