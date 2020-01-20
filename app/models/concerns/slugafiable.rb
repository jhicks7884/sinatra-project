module Slugafiable
    module InstanceMethods

    def def slug
        username.parameterize
    end

    module ClassMethods

        def find_by_slug(slug)
            self.all.detect {|i| i.username.parameterize === slug}
        end
    end
  end
end