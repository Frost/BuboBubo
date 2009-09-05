module BuboBubo
  module FindMethods
    def self.included(base)
      base.extend(InstanceMethods)
      base.class_eval { include InstanceMethods }
    end
    
    module InstanceMethods
      def listing(params, options = {}, find_options = {})
        ferret_options = {}
        
        # the default name for a listing is listing
        options[:name] ||= :listing

        listing_hash = params[options[:name]] || {}
        find_options[:order] ||= "id ASC"
        if listing_hash[:sort]
          find_options.delete(:order)
          
          column = listing_hash[:sort][:column]
          order = listing_hash[:sort][:reverse] == "true" ? "DESC" : "ASC"

          find_options[:order] = "#{column} #{order}"
        end
        
        scopes = []
        
        if filters = listing_hash[:filters]
          filters.each do |filter, value|
            scopes << "#{filter}_filter(\"#{value}\")" unless value.blank?
          end
        end

        klass = scopes.empty? ? self : self.instance_eval(scopes.join('.'))
        
        search_results = SearchResults.new(klass.find(:all, :order => find_options[:order]))
        
        # save the settings inside the SearchResults object so we can use them inside our view later on
        search_results.settings[:name] = options[:name]
        search_results.settings[:filters] = listing_hash[:filters] || {}
        search_results.settings[:sort] = listing_hash[:sort] || {}
        search_results.settings[:available_filters] = self._available_filters

        search_results
      end
    end
  end
end