require 'csv'

class FarMar::Market

  attr_accessor :id,
                :name,
                :address,
                :city,
                :county,
                :state,
                :zip

  def initialize (attrs)
    @id         = attrs[:id]
    @name       = attrs[:name]
    @address    = attrs[:address]
    @city       = attrs[:city]
    @county     = attrs[:county]
    @state      = attrs[:state]
    @zip        = attrs[:zip]
  end

  def self.all

      # CSV.open("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/markets.csv", "r")
      # IRB: all = FarMar::Market.open
      # calling this in IRB just makes the CSV accesssible
      # need to have all contents become instances of Market class

    all_markets = CSV.open("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/markets.csv", "r")

    attributes = all_markets.map do |m| # will return array of hashes, each containing all info per market
      { id:       m[0],
        name:     m[1],
        address:  m[2],
        city:     m[3],
        county:   m[4],
        state:    m[5],
        zip:      m[6]
      }
    end

      # this code works for getting a single market object:
        # first_market = FarMar::Market.new(attributes[0])

        # puts first_market.class
          # => FarMar::Market

        # puts first_market.inspect
          #<FarMar::Market:0x007fc0e191cf90 @id="1", @name="People's Co-op Farmers Market", @address="30th and Burnside", @city="Portland", @county="Multnomah", @state="Oregon", @zip="97202">

    # this code returns array of 500 FarMar::Market objects, each of which contains hash of all relevant data
    markets_as_objects = attributes.map do |m|
      FarMar::Market.new(m)
    end

    puts "Class of markets_as_objects:"
    puts markets_as_objects.class
    puts
    puts "Class of first index in markets_as_objects:"
    puts markets_as_objects[0].class
    puts
    puts "Contents of first index in markets_as_objects:"
    puts markets_as_objects[0].inspect

  end

# CLASS METHOD 2:
# self.find(id) - returns the row where the ID field matches the argument
# does same thing for a single given row, accessed by its ID (# in first column in markets.csv)
# we should get a new instance of market object back when query its ID

  # def self.find(id)
  #   market = CSV.open("[[filepath]]", "r")
  # end

end
