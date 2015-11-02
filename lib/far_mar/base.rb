class FarMar::Base

  attr_reader :id

  def initialize(id)
    @id = id.to_i
  end

  def self.find(id)
    self.all.find {|object| object.id == id}
  end

end
