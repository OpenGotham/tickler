require File.expand_path('../helper', __FILE__)

class TestGroper < MiniTest::Unit::TestCase
  def setup
    @groper = Groper.new
  end

  def test_url
    assert @groper.urls.is_a?(Array)
  end

  # just make sure that something happens
  def test_parsing_xml
    filename = File.expand_path(File.join('..','fixtures','Estimize_Intraday_A.xml'), __FILE__)
    @groper.parse(IntradayParser, filename)
    assert true
  end
end
