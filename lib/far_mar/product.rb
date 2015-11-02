require 'csv'

class FarMar::Product < FarMar::Base

  PRODUCT_ARRAY = CSV.read("support/products.csv")

  attr_reader :name,
              :vendor_id

    def initialize(attrs)
      super(attrs[:id])
      @name        = attrs[:name]
      @vendor_id   = attrs[:vendor_id].to_i
    end

  def self.all
    # self.all - returns all rows of the CSV file as objects
    new_product_array = []
    # reads products.csv file
    # product_array = CSV.read("support/products.csv")
    PRODUCT_ARRAY.each do |product|
      # loop through all attributes of market
      product_info = {
        id:         product[0],
        name:       product[1],
        vendor_id:  product[2]
      }
      # create new product object
      new_product = FarMar::Product.new(product_info)
      # push each new product object into one array called new_product_array
      new_product_array << new_product
    end
    return new_product_array
  end

  # def self.find(id)
  #   # self.find(id) - returns the row where the ID field matches the argument
  #   # product_array = CSV.read("support/products.csv")
  #   # self.all.find {|object| object.id == id}
  #   # PRODUCT_ARRAY.each do |product|
  #   #   product_info = {
  #   #     id:         product[0],
  #   #     name:       product[1],
  #   #     vendor_id:  product[2],
  #   #   }
  #   #   if product[0].to_i == id
  #   #     new_product = FarMar::Product.new(product_info)
  #   #     return new_product
  #   #   end
  #   # end
  # end

  def vendor
    # vendor - returns the Vendor instance that is associated with this vendor using the Product vendor_id field
    FarMar::Vendor.find(@vendor_id)
  end

  def sales
    # sales - returns a collection of Sale instances that are associated with market using the Sale product_id field.
    # return a list of sale info depending on what product was sold
    # sale_instances = []
    all_sales = FarMar::Sale.all
    all_sales.find_all { |sale| sale.product_id == @id}
    #   if sale.product_id == @id
    #     sale_instances << sale
    #   end
    # end
    # return sale_instances
  end

  def number_of_sales
    # number_of_sales - returns the number of times this product has been sold.
    # count how many times a vendor sells a product
    # product_id in Sale equals id in Product
    # sales = 0
    FarMar::Sale.by_product(@id).length
    # all_sales = FarMar::Sale.all
    # all_sales.each do |sale|
    #   if sale.product_id == @id
    #     sales += 1
    #   end
    # end
    # return sales
  end

  def self.by_vendor(vendor_id)
    # self.by_vendor(vendor_id)- returns a list of all Product objects with a vendor id that matches the input
    # product_objects = []
    product_array = self.all # same as FarMar::Product.all
    product_array.find_all {|product| product.vendor_id == vendor_id}
    #   if product.vendor_id == vendor_id
    #     product_objects << product
    #   end
    # end
    # return product_objects
  end

  def self.find_by_product(product_name)
    product_array = self.all
    product_array.find_all {|product| product.name.downcase.include? product_name.downcase}
  end

end
