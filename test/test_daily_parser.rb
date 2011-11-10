require File.expand_path('../helper', __FILE__)

class TestDailyParser < MiniTest::Unit::TestCase
  def setup
    InstrumentDocument.destroy_all
    @groper = Groper.new
    filename = File.expand_path(File.join('..','fixtures','Estimize_Daily_A.xml'), __FILE__)
    @groper.parse(DailyParser, filename)
  end

  def test_record_stored_on_parse
    records = InstrumentDocument.all
    record  = records.first
    assert_equal 1829, records.length, "Wrong number of documents stored."
    assert record.symbol.is_a?(String)
    assert record.company_name.is_a?(String)
  end
end
