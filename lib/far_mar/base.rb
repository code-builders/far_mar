class FarMar::Base

  def initialize (attrs)

  end

  def read_file
    "needs to be defined"
  end

  # NEW
  # def result
  #   @result ||= self.read_file
  # end

  def self.all
    # self.read_file.map {|x| self.new(x)}
    @all ||= self.read_file.map {|x| self.new(x)} # => all .all methods memoized! 
  end

  def self.find (id)
    self.all.find {|x| x.id == id}
  end

  # def read_csv # => read CSVs for each class
  #   all_objects = CSV.read("support/#{[class name]}.csv", "r")
  # end

  # def result2
  #   @result ||= self.read_csv
  #   # if result of reading CSV is already there, return result
  #   # || OR
  #   # if result of reading CSV is not there (first time reading), go read CSV
  #
  #   # So, will have to call .result on read_csv for each class!
  #   # => because each CSV read has to be tested for whether it's been done before &
  #   # data is available...or not.
  #
  #   # Flow:
  #   # in BASE, .read__ just contains read CSV filepath (all or each interpolated TBD)
  #   # in each class, .read__ inherits from Base, and *in addition* is overwritten
  #   #    with proper attributes for that class
  #   ## AND/OR?
  #   # in each class, call .result on .read__ (define .read __ above and then call
  #   #    .result on it, for that class)
  #
  # end

end
