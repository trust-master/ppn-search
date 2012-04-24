module RoutingConstraints
  class Pages
    def self.matches?(request)
      Page.slug_map.keys.include?(request.params[:slug])
    end
  end
end