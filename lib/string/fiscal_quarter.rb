class FiscalQuarter
  attr_accessor :year, :quarter

  def initialize(string_representation = "")
    if match = string_representation.match(/FQ([\d]{1})_([\d]{4})/)
      @year    = match[2].to_i
      @quarter = match[1].to_i
    end
  end

  def to_s
    "FQ#{@quarter}_#{@year}"
  end

  def aged(qtrs)
    raise "We don't time travel." if qtrs < 1

    total_quarters = @year * 4 + @quarter - qtrs
    new_quarter = self.class.new
    new_quarter.year    = (total_quarters / 4).floor
    new_quarter.quarter = (total_quarters % 4) + 1
    return new_quarter
  end

end
