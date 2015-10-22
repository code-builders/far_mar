class FarMar::Base

  def initialize (attrs)

  end

  def read_file
    "needs to be defined"
  end

  def self.all
    self.read_file.map {|x| self.new(x)}
  end

  def self.find (id)
    self.all.find {|x| x.id == id}
  end

end
