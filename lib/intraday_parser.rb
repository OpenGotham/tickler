class IntradayParser < Nokogiri::XML::SAX::Document
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
      @record = IntradayDocument.new
      @record.body = {}
      @document.each do |pair|
        case pair[0]
        when 'Symbol'
          @record.symbol = pair[1]
        when 'CompanyName'
          @record.company_name = pair[1]
        else
          @record.body[pair[0].to_sym] = pair[1]
        end
      end
      @record.save
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
