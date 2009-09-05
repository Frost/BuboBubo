module BuboBubo
  module Helper
    class Filter
      attr_accessor :definitions
    
      def initialize(options)
        self.definitions = []
      end
    
      def text_filter(method, options = {})
        options[:label] ||= method.to_s.humanize
    
        self.definitions << {:type => :text, :method => method, :name => options[:label]}
      end
    
      def options_filter(method, choices, options = {})
        options[:label] ||= method.to_s.humanize
    
        self.definitions << {:type => :option, :choices => choices.collect {|c| [c.to_s, c.id]}, :method => method, :name => options[:label]}
      end
    end
  end
end