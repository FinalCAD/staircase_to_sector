# Public: Chain processes the all processes
#
module StaircaseToSector
  module Processors
    class StaircaseComposer < StaircaseToSector::Processors::Base

      def process(model:, context: {})
        staircase_model = model

        Processors::CreateLayout.new(options).process(model: staircase_model, context: context)
        # Assemble PNG
        Processors::ComposeGrid.new(options).process(model: staircase_model, context: context)
        # Annotate PNG
        Processors::Annotate.new(options).process(model: staircase_model, context: context)
        # Move Zone into the target place
        Processors::MoveZone.new(options).process(model: staircase_model, context: context)
        # Set metadata for a Staircase based on his sectors
        Processors::Metadata::Sector.new(options).process(model: staircase_model, context: context)
        # Set the new metadata for a Zone based on the created Staircase
        Processors::Metadata::Zone.new(options).process(model: staircase_model, context: context)

        nil
      end

    end
  end
end
