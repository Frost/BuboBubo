require 'bubo_bubo'

ActionView::Base.send :include, BuboBubo::Helper::HelperMethods

ActiveRecord::Base.send :include, BuboBubo

ActiveRecord::Base.send :include, BuboBubo::FindMethods
ActiveRecord::Associations::AssociationProxy.send :include, BuboBubo::FindMethods
