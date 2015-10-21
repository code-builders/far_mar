#lib/far_mar/market.rb
require 'csv'

class FarMar::Market#capitalize all names of class
  attr_reader
    :id
    :name
    :address
    :city
    :county
    :state
    :zip

   def initialize (attrs)
     @id= attrs[0]  #use blocks to access the key of the block in line 28#syntax to pass something into an has
     @name   = attrs[1]
     @address = attrs[2]
     @city = attrs[3]
     @county= attrs[4]
     @state= attrs[5]
     @zip = attrs[6]
   end



  # returns all rows of the CSV file as objects

  def self.all
    a=CSV.read("support/markets.csv")#read the CSV file
    a.collect do |row|
    FarMar::Market.new (row)
    # read the markets.csv file
    # for each row
    # create a new instance of FarMar::Market
    # create an array of those instances
    # return that array
    end
  end


  def self.find(i) #find id
    a=CSV.read("support/markets.csv")
    row_match=a.collect do |row|
    i == row[0]
    end

    FarMar::Market.new(row_match)
  end




# vendors - returns a collection of Vendor instances that are associated with the market by the market_id field.








end
#
#
#
#
#
#   #
  # vendors - returns a collection of Vendor instances that are associated with the market by the market_id field.
#   # find_by_state(state_name) - Returns the first Market object with a state name which matches the input
#   # find_all_by_state(state_name) - Returns a list of all Market objects with a state name that matches the input
#
#
#



#
# vendors - returns a collection of Vendor instances that are associated with the market by the market_id field.
