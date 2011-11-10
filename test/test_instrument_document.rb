require File.expand_path('../helper', __FILE__)

class TestInstrumentDocument < MiniTest::Unit::TestCase
  def setup
    record = InstrumentDocument.find('BEOS')
    record.destroy if record

    @array_1 = [
      ['Symbol','BEOS'],
      ['CompanyName', 'Be, Inc.'],
      ['Sales1', '777'],
      ['Sales2', '666'],
      ['Sales3', '555'],
      ['EPSQuarterly1', '0.44'],
      ['EPSQuarterly2', '0.51'],
      ['EPSQuarterly3', '0.49'],
      ['LatestFiscalQTR', '3'],
      ['LatestFiscalYear', '2011']
    ]
    @array_2 = [
      ['Symbol','BEOS'],
      ['Sales1', '777'],
      ['LatestFiscalQTR', '3'],
      ['LatestFiscalYear', '2011']
    ]
    @array_3 = [
      ['Symbol','BEOS'],
      ['EPSQuarterly1', '0.44'],
      ['LatestFiscalQTR', '3'],
      ['LatestFiscalYear', '2011']
    ]
  end

  def test_creation_of_record_from_array
    expected_sales        = {"FQ3_2011" => 777.0, "FQ2_2011" => 666.0, "FQ1_2011" => 555.0}
    expected_eps_quarterly= {"FQ3_2011" => 0.44, "FQ2_2011" => 0.51, "FQ1_2011" => 0.49}
    record = InstrumentDocument.save_from_array(@array_1)
    assert_equal "BEOS", record.symbol
    assert_equal "Be, Inc.", record.company_name
    assert_equal expected_sales, record.sales
    assert_equal expected_eps_quarterly, record.eps_quarterly
  end

  def test_find_by_symbol
    record_1 = InstrumentDocument.save_from_array(@array_1)
    record_2 = InstrumentDocument.find('BEOS')
    assert_equal record_1, record_2
  end

  def test_raises_error_from_insufficient_array
    assert_raises(RuntimeError) do
      InstrumentDocument.save_from_array([['LatestFiscalQTR','3'],['LatestFiscalYear','2011']])
    end
    assert_raises(RuntimeError) do
      InstrumentDocument.save_from_array([['Symbol','BEOS'],['LatestFiscalYear','2011']])
    end
    assert_raises(RuntimeError) do
      InstrumentDocument.save_from_array([['Symbol','BEOS'],['LatestFiscalQTR','3']])
    end
  end

  def test_create_part_of_save
    assert InstrumentDocument.find('BEOS').nil?, "Riak should not contain this object yet." 
    record = InstrumentDocument.save_from_array(@array_1)
    assert_equal "BEOS", record.symbol
    assert_equal "Be, Inc.", record.company_name
  end

  def test_update_part_of_save
    record = InstrumentDocument.save_from_array(@array_2)
    record = InstrumentDocument.save_from_array(@array_3)
    assert_equal({"FQ3_2011" => 777},  record.sales)
    assert_equal({"FQ3_2011" => 0.44}, record.eps_quarterly)
  end
end
