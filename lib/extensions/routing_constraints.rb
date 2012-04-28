module RoutingConstraints
  class Pages
    def self.matches?(request)
      Page.meta_map.values.any?{ |p| p[:slug] == request.params[:slug] }
    end
  end
end