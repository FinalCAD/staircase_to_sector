module StaircaseToSector
  module Lib
    class Cursor

      def initialize(columns:, rows:)
        @column_cursor = CellPosition.new(columns)
        @row_cursor    = CellPosition.new(rows)
      end

      def move
        Point.new(x: next_column, y: next_row)
      end

      private

      attr_reader :column_cursor, :row_cursor, :columns, :rows

      def next_column
        column_cursor.next_position { change_row! }
      end

      def next_row
        reset_row! if column_changed?
        @current_row ||= row_cursor.next_position
      end

      def column_changed?
        column_cursor.current_position == columns
      end

      def reset_row!
        @row_cursor = CellPosition.new(rows)
      end

      def change_row!
        @current_row = nil
      end

      class CellPosition
        def initialize(size)
          @size = size
          @position = -1
        end

        def next_position
          reset if reached_bound?
          if block_given?
            yield if reinitiated?
          end
          @position += 1
        end

        def current_position
          @position
        end

        private

        def reset
          @position = -1
        end

        def reinitiated?
          @position == -1
        end

        attr_reader :size

        def reached_bound?
          (@position + 1) >= size
        end
      end

    end
  end
end
