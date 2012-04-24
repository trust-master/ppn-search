module RoutingConstraints
  class Pages
    def self.matches?(request)
      Page.slug_map.has_value?(request.params[:slug])
    end
  end
end