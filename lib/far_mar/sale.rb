require 'csv'

class FarMar::Sale
  attr_accessor :id, :amount, :time_purchased, :vendor_id, :product_id

  def initialize(attrs)
    @id             = attrs[:id]
    @amount         = attrs[:amount]
    @time_purchased = attrs[:time_purchased]
    @vendor_id      = attrs[:vendor_id]
    @product_id     = attrs[:product_id]
  end

    def self.all
      sales = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/sales.csv", "r")
      sales.read.collect do |attrs|
        sls = {
          id: attrs[0],
          amount: attrs[1],
          time_purchased: attrs[2],
          vendor_id: attrs[3],
          product_id: attrs[4],
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
