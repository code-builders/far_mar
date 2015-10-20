
require 'csv'

class FarMar::Market
  attr_accessor :id, :name, :address, :city, :county, :state, :zip

  def initialize(attrs)
   @id= attrs[:id]
   @name = attrs[:name]
   @address = attrs[:address]
   @city = attrs[:city]
   @county = attrs[:county]
   @state= attrs[:state]
   @zip = attrs[:zip]
  end

  def self.all
    markets = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/markets.csv", "r")
    markets.read.collect do |attrs|
      mkts = {
        id: attrs[0],
        name: attrs[1],
        address: attrs[2],
        city: attrs[3],
        county: attrs[4],
        state: attrs[5],
        zip: attrs[6]
      }
      m = FarMar::Market.new(mkts)
    end
  end

  def self.find(id)
    id= id.to_s
    markets = self.all
    markets.find do |f|
      f.id.to_s == id
    end
  end



      #m= self.new(mkts)
      #fmarkets << m
    #end
  #end


      #for each row, create new market

      #@name = attrs[0]


    #@ID = attrs[0]
#    puts @Name
    #@Address
    #@City
    #@County
    #@State
    #@Zip



  #  )
  #set attr _accessors for the class
  #read csv file and separate each row
  #initialize each instance of the market requiring hash of attrs
  #define instance viariablesin all class
  #each row of the CSV is a market instance
  #from each row, we need to define the 7 attributes that come from the columns in the CSV

 def placeholder
    markets = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/markets.csv", "r")
    #everything = markets.read
  #  puts markets.read
    markets.sort_by do |r|
    end
 end

  def self.count
    file = CSV.open("/Users/khambro/CodeBuilders/far_mar/support/markets.csv", "r")
    file.sort_by do |b|
      b.object_id
    end
  end


  #self.all - returns all rows of the CSV file as objects
#self.find(id) - returns the row where the ID field matches the argument

end
