module BuboBubo
  class SearchResults
    attr_accessor :collection, :settings
    def initialize(collection)
      self.collection = collection
      self.settings = {}
    end
    
    def each(&block)
      self.collection.each(&block)
    end
  end
end