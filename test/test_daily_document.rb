require File.expand_path('../helper', __FILE__)

class TestDailyDocument < MiniTest::Unit::TestCase
  def setup
    @array = [
      ['Symbol','BeOS'],
      ['CompanyName', 'Be, Inc.'],
      ['OtherJunk', '777']
    ]
  end

  def test_creation_of_record_from_array
    record = DailyDocument.create_from_array(@array)
    assert_equal "BeOS", record.symbol
    assert_equal "Be, Inc.", record.company_name
    assert_equal({"OtherJunk" => '777'}, record.body)
  end
end
