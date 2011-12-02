class Discount < ActiveRecord::Base
    belongs_to :company
    validates_presence_of :type_id, :title, :start_date, :end_date
    def type_name
        type = Discount.AvailableTypes.find{|item| item.id == self.type_id }
        raise "Could not locate type by id #{self.id} in the enum" if type.nil?
        return type.name
    end
    def self.AvailableMarkets
        return [
            Market.new({id: 1, name: "Minneapolis"}),
            Market.new({id: 2, name: "Saint Paul"}),
            Market.new({id: 3, name: "Eden Prairie"})
        ]
    end
    def self.AvailableTypes
        return [
            DiscountType.new({id: 1, name: "Super Deep"}),
            DiscountType.new({id: 2, name: "Deep"}),
            DiscountType.new({id: 3, name: "Sort of Deep"})
        ]
    end
end
class DiscountType
    attr_accessor :id
    attr_accessor :name
    def initialize params
        @id = params[:id]
        @name = params[:name]
    end
end
class Market
    attr_accessor :id
    attr_accessor :name
    def initialize params
        @id = params[:id]
        @name = params[:name]
    end
end

