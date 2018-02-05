module StaircaseToSector
  module Models
    class Zone
      include Base

      def short_name
        Pathname(if name.to_s =~ /-=-/
          name.to_s.split('-=-').first
        elsif name.to_s =~ /-==-/
          name.to_s.split('-=+-').first
        else
          name.to_s
        end)
      end

    end
  end
end
