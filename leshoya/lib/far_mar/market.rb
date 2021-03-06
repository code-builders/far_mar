#lib/far_mar/market.rb
require 'csv'

class FarMar::Market  #capitalize all names of class
  attr_accessor :id, :name, :address, :city, :county, :state, :zip

   def initialize(attrs)
     @id= attrs[0].to_i
     #use blocks to access the key of the block in line 28#PASSED THIS INFORMATION INTO AN ARRAY!! INTO A HASH WOULD BE [:]
     @name   = attrs[1]
     @address = attrs[2]
     @city = attrs[3]
     @county= attrs[4]
     @state= attrs[5]
     @zip = attrs[6]
   end

 # returns all rows of the CSV file as objects


  def self.all
#read the CSV file
    read_file.collect do |row|
    FarMar::Market.new (row)
    # read the markets.csv file
    # for each row
    # create a new instance of FarMar::Market
    # create an array of those instances
    # return that array
    end
  end



# self.find(id) - returns the row where the ID field matches the argument
  def self.find(id) #find id
    row_match=read_file.find do |row|
    id == row[0].to_i
    end
    FarMar::Market.new(row_match) #don't forget to make a new instance
  end
    # read the csv file of markets
    # for each row
    # create a new instance of FarMar:: Market
    # compare the i variable(parameter coming in) to the market row id
    # return if that is a match
    # creat a new instance with that match


  def self.find_by_name(name)
    all.find do |x|
    name == x.name
    end
  end
# NOTES:
# with `all.find do |x|`, it’s going to go over each object returned by `all`.
# In that block `x` is going to a `FarMar::Market` object.
# Where you are using `x[1]`, this is the syntax you would use if this data were
# still an Array, but now it’s a `FarMar::Market`, so array syntax
# doesn’t work anymore.Instead of `x[1]`, you would use `x.name`.


# Returns the first Market object with a state name which matches the input
  def self.find_by_state(state_name)
    all.find do |x|
    state_name == x.state
    end
  end

# Returns a list of all Market objects with a state name that matches the input
  def self.find_all_by_state(state_name)
    all.find_all do |x|
    state_name == x.state
    end
  end


# vendors - returns a collection of Vendor instances that are associated with the market by the market_id field.
  def self.vendorcollection(id)
    all.find_all do |x|
    id.to_i==x.id
    end
  end
  #retrieve market id
  #get market id from Vendor classfile
  #match up market id and vendor id
  #provide a collection of all vendor instances associated with market by id

  def vendors ##DON'T NEED TO PASS IN AN ARGUMENT JUST THE VALUE FROM THE ARGUMENT!!!!
  # lookup every vendor that matches this market id
    FarMar::Vendor.by_market(@id)
  ##OMG YAY, REMEMBER THIS TO BRING IN CLASSES FOR DIFFERENT METHODS,
  ##bring in class object and method and pass in the id from market
  end
  #retrieve market id
  #get market id from Vendor classfile
  #match up market id and vendor id
  #provide a collection of all vendor instances associated with market by id
  #read file method

  def self.read_file
   CSV.read("support/markets.csv")
  end







end
