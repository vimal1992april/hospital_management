if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        def total_count
          count
        end
      end
    end
  end
end
