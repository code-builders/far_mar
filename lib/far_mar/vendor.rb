require 'csv'

class FarMar::Vendor
  attr_accessor :id, :name, :num_employees, :market_id

  def initialize(attrs)
   @id= attrs[:id]
   @name = attrs[:name]
   @employees = attrs[:num_employees]
   @market_id = attrs[:market_id]
  end

  def self.all
    vendors = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/vendors.csv", "r")
    vendors.read.collect do |attrs|
      vend = {
        id: attrs[0],
        name: attrs[1],
        num_employees: attrs[2],
        market_id: attrs[3],
      }
      self.new(vend)
    end
  end

  def self.find(id)
    id = id.to_i
    vendors = self.all
    vendors.find do |f|
      f.id.to_i == id.to_i
    end
  end

end
