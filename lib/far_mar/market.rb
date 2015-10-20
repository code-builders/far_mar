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

  # INSTANCE VARIABLES:
  @all_markets = CSV.open("/Users/danieladler/Programming/Code_Builders/ruby_practice/projects/far_mar/support/markets.csv", "r")

  @attributes = @all_markets.map do |m| # will return array of hashes, each containing all info per market
    { id:       m[0],
      name:     m[1],
      address:  m[2],
      city:     m[3],
      county:   m[4],
      state:    m[5],
      zip:      m[6]
    }
  end

  # CLASS METHOD 1
  def self.all # returns array of 500 FarMar::Market objects, each of which contains hash of all relevant data

    all_markets_as_objects = @attributes.map do |m|
      FarMar::Market.new(m)
    end

    # random = @all_markets_as_objects.sample
    # puts "Contents of random index in all_markets_as_objects:"
    # puts random.inspect
  end

  # CLASS METHOD 2:
  def self.find (id)
    all_markets = self.all

    all_markets.find {|m| m.id == id.to_s}

    # this works:
      # puts "id of random market"
      # random_id = @all_markets_as_objects.sample.id
      # puts random_id

    # this works:
      # found_id = @all_markets_as_objects.find {|m| m.id == "1"}
      # puts found_id.name
  end
end
