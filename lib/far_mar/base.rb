class FarMar::Base

  def self.all
    @all ||= CSV.read(path).map { |line| new(line) }
  end

  def self.find(id)
    array = CSV.read(path)
    row_match = array.find { |row| id == row[0].to_i }
    new(row_match)
  end

end
