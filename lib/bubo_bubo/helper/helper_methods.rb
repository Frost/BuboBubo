module BuboBubo
  module Helper
    module HelperMethods
      def pagination(collection, options = {})
        will_paginate collection, :param_name => "#{collection.settings[:name]}[page]"
      end
    
      def listing(collection, options = {}, &block)
        options[:renderer] ||= TableRenderer
    
        renderer = options[:renderer].new(collection, options, self)
    
        yield renderer
    
        renderer.render
      end
    
      def filters(collection, options = {}, &block)
        options[:class] ||= :filters
        options[:method] = :get
        options[:submit_text] ||= 'Filter'
        
        form_tag('', options) do
          filter = Filter.new(options)
    
          yield filter
    
          output = ""
    
          filter.definitions.each do |definition|
            tag = "#{collection.settings[:name]}[filters][#{definition[:method]}]"
    
            output += label_tag tag, definition[:name]
    
            case definition[:type]
            when :text 
              output += text_field_tag tag, collection.settings[:filters][definition[:method]]
            when :option
              output += select_tag tag, options_for_select([["", ""]] + definition[:choices], collection.settings[:filters][definition[:method].to_s])
            end
          end
    
          output += submit_tag options[:submit_text], :disable_with => 'Filtering..'
    
          output
        end
      end
    end
  end
end
