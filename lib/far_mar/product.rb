require 'csv'

class FarMar::Product
  attr_accessor :id, :name, :vendor_id

  def initialize(attrs)
   @id= attrs[:id]
   @name = attrs[:name]
   @vendor_id = attrs[:vendor_id]
  end

  def self.all
    products = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/products.csv", "r")
    products.read.collect do |attrs|
      pdts = {
        id: attrs[0],
        name: attrs[1],
        vendor_id: attrs[2],
      }
      self.new(pdts)
      end
  end

  def self.find(id)
    id= id.to_i
    products = self.all
    products.find do |f|
     f.id.to_i == id.to_i
    end
  end

end
