require 'csv'
#
class FarMar::Product

  attr_reader :id, :name, :vendorid

  def initialize(attrs)

    @id =attrs[0].to_i
    @name =attrs[1]
    @vendorid =attrs[2]

  end

# self.all - returns all rows of the CSV file as objects
  def self.all
    read_file.collect do |row|
    FarMar::Product.new(row)
    end
  end

# self.find(id) - returns the row where the ID field matches the argument
  def self.find(id)
    read_file.find do |row|
    id == row[0].to_i
    end
  end

#READ FILE METHOD
  def self.read_file
    CSV.read("support/products.csv")
  end


  # vendor - returns the Vendor instance that is associated with this vendor using the Product vendor_id field
#
# self.by_vendor(vendor_id)`- returns a list of all `Product` objects with a vendor id that matches the input"
  # def self.by_vendor(vendor_id)
  #   read_file.find_all do |vendor_id|
  #
  #
  # end

  # def vendor(x)
  #   read_file.find do |x|
  #   x == row[2].to_i
  #
  # end

end
#
