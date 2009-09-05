require 'will_paginate'

module BuboBubo
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def listing_filter(filters)
      @available_filters = []

      fields = {}

      filters.each do |name, definition|
        method_declaration = lambda do
          if definition.is_a? Proc
            named_scope "#{name}_filter".to_sym, definition
          elsif definition.is_a? Symbol or definition.is_a? String
            named_scope "#{name}_filter".to_sym, lambda {|name| { :conditions => ["#{definition} = ?", name] } }
          else
            raise 'Error: Filter needs to be either a Symbol, String or a Proc'
          end
        end

        @available_filters << name

        self.instance_eval(&method_declaration)
      end

      # save the available filters in the class for use in the view later on
      (class << self; self; end).class_eval do
        def _available_filters
          @available_filters
        end
      end
    end
  end
end