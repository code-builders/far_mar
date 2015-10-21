#lib/far_mar/sale.rb
require 'csv'

class FarMar::Sale #capitalize all names of class

  attr_reader
    :id
    :saleamount
    :purchasetime
    :vendorid
    :productid

    def initialize(attrs)
      @id= attrs[:id]
      @saleamount=attrs[:saleamount]
      @purchasetime=attrs[:purchasetime]
      @vendorid=attrs[:vendorid]
      @productid=attrs[:productid]

    end

    def self.all
      new_sale_array = []
      a=CSV.read("support/sales.csv")#read the CSV file
      a.each do |row|

          row_info= {
                id:row[0].to_i,
                saleamount:row[1],
                purchasetime: row[2],
                vendorid: row[3],
                productid: row[4]}
    #
        new_sale = FarMar::Sale.new(row_info)
        new_sale_array << new_sale
      end

    end



        def self.find(id)
          new_sale_object = []
          a=CSV.read("support/sales.csv")#read the CSV file
          a.each do |row|

              row_info= {
                    id:row[0].to_i,
                    saleamount:row[1],
                    purchasetime: row[2],
                    vendorid: row[3],
                    productid: row[4]}

            if row[0].to_i == id
              newsale = FarMar::Sale.new(row_info)
              new_sale_object << newsale
            end
          end
          new_sale_object
        end
      # new_sale_array






end
