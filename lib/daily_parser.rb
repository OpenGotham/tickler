class DailyParser < Nokogiri::XML::SAX::Document
  def start_element(name, attrs = [])
    case name
    when 'RecordDetails'
      @document = []
    else
      @document << [name] if @document
    end
  end

  # write the document to the database
  def end_element(name)
    if name == 'RecordDetails'
      @record = InstrumentDocument.save_from_array(@document)
      @document = nil
    end
  end

  # append value to the most recent element we were building
  def characters(value)
    @document.last << value if @document
  end

  def end_document
  end
end
