class FarMar::Base

  def self.read_file
    @read_file ||= CSV.read(path)
  end

  def self.all
    @all ||= read_file.map { |line| new(line) }
  end

  def self.find(id)
    row_match = read_file.find { |row| id == row[0].to_i }
    new(row_match)
  end

end
