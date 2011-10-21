require File.expand_path('../helper', __FILE__)

class TestIntradayParser < MiniTest::Unit::TestCase
  def setup
    IntradayDocument.destroy_all
    @groper = Groper.new
    filename = File.expand_path(File.join('..','fixtures','Estimize_Intraday_A.xml'), __FILE__)
    @groper.parse(filename)
  end

  def test_record_stored_on_parse
    records = IntradayDocument.all
    record  = records.first
    assert_equal 8, records.length, "Wrong number of documents stored."
    assert record.symbol.is_a?(String)
    assert record.company_name.is_a?(String)
    assert record.body.is_a?(Hash)
  end
end
