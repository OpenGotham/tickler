require File.expand_path('../helper', __FILE__)

class TestFiscalQuarter < MiniTest::Unit::TestCase
  def test_attributes
    assert FiscalQuarter.new.respond_to? :year
    assert FiscalQuarter.new.respond_to? :quarter
  end

  def test_parsing_from_new_string
    fq = FiscalQuarter.new("FQ4_1969")
    assert_equal 4,    fq.quarter
    assert_equal 1969, fq.year
  end

  def test_conversion_to_string
    fq = FiscalQuarter.new("FQ4_1969")
    assert_equal "FQ4_1969", fq.to_s
  end

  def test_aged_quarter
    assert_equal "FQ4_2011", FiscalQuarter.new("FQ4_2011").aged(1).to_s
    assert_equal "FQ4_2004", FiscalQuarter.new("FQ1_2005").aged(2).to_s
    assert_equal "FQ1_2000", FiscalQuarter.new("FQ3_2001").aged(7).to_s
  end
end
