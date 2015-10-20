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
     @id= attrs[:id]  #use blocks to access the key of the block in line 28
     @name   = attrs[:name]
     @address = attrs[:address]
     @city = attrs[:city]
     @county= attrs[:county]
     @state= attrs[:state]
     @zip = attrs[:zip]
   end


   def self.all
     new_market_array= []
     a=CSV.read("support/markets.csv")#read the CSV file
     a.each do |row|

       row_info = {
         id:row [0].to_i,
         name:  row[1],
         address: row[2],
         city: row [3],
         count: row[4],
         state: row[5],
         zip: row[6],
       }
       new_market = FarMar::Market.new(row_info)
       new_market_array << new_market
     end
     end






#
  def self.find(id)

    new_market_array= []
    a=CSV.read("support/markets.csv")#read the CSV file
    a.each do |row|

      row_info = {
        id:row [0].to_i,
        name:  row[1],
        address: row[2],
        city: row [3],
        count: row[4],
        state: row[5],
        zip: row[6],
      }

      if row[0].to_i == id
        newmarket = FarMar::Market.new(row_info)
        new_market_object<< newmarket
      end
    end
end
  end
