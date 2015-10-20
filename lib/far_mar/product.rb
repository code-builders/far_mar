require 'csv'
#
class FarMar::Product

  attr_reader
    :productid
    :productname
    :productamount

    def initialize(attrs)

        @productid  =attrs[:productid]
        @productname =attrs[:productname]
        @productamount =attrs[:productamount]

    end

    def self.all
      new_product_array= []
      a=CSV.read("support/products.csv")#read the CSV file
      a.each do |row|


        row_info = {
          productid:row [0].to_i,
          productname:  row[1],
          productamount: row[2],

        }
        new_product= FarMar::Product.new(row_info)
        new_product_array << new_product
        end
        new_product_array
    end
  
#
    def self.find(id)
      new_product_object = []
      a=CSV.read("support/products.csv")
      a.each do |row|

        row_info = {
          productid: row[0].to_i,
          productname: row[1],
          productamount: row[2],
          }

        if row[0].to_i == id
          newproduct = FarMar::Product.new(row_info)
          new_product_object << newproduct
        end
      end
      new_product_object
    end

end
