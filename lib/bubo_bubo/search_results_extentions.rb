module BuboBubo
  module SearchResultsExtentions
    def self.included(base)
      base.class_eval { include InstanceMethods }
    end
    
    module InstanceMethods
      def settings
        @bubo_bubo_filters ||= {}
      end
    end
  end
end