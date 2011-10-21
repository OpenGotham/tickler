class DailyDocument
  include Ripple::Document
  property :symbol,       String, :presence => true
  property :company_name, String, :presence => true
  property :body,         Hash

  def self.create_from_array(pairs)
    record = DailyDocument.new
    record.body = {}
    pairs.each do |pair|
      case pair[0]
      when 'Symbol'
        record.symbol = pair[1]
      when 'CompanyName'
        record.company_name = pair[1]
      else
        record.body[pair[0].to_sym] = pair[1]
      end
    end
    record.save
    record
  end
end
