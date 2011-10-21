require File.expand_path('../helper', __FILE__)

class TestGroper < MiniTest::Unit::TestCase
  def setup
    @groper = Groper.new
  end

  def test_url
    assert_equal "Estimizer.xml", @groper.url
  end

  def test_parsing_xml
    filename = File.expand_path(File.join('..','fixtures','Estimize_Intraday_A.xml'), __FILE__)
    @groper.parse(filename)
    assert true
  end
end
