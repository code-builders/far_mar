require 'csv'

class FarMar::Sale
  attr_accessor :id, :amount, :time_purchased, :vendor_id, :product_id

  def initialize(attrs)
    @id             = attrs[:id].to_i
    @amount         = attrs[:amount].to_i
    @time_purchased = attrs[:time_purchased]
    @vendor_id      = attrs[:vendor_id].to_i
    @product_id     = attrs[:product_id].to_i
  end

    def self.all
      sales = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/sales.csv", "r")
      sales.read.collect do |attrs|
        sls = {
          id: attrs[0].to_i,
          amount: attrs[1].to_i,
          time_purchased: attrs[2],
          vendor_id: attrs[3].to_i,
          product_id: attrs[4].to_i,
        }
      self.new(sls)
      end
    end

    def self.find(id)
      id= id.to_i
      sales = self.all
      sales.find do |f|
        f.id.to_i == id.to_i
      end
    end

end
