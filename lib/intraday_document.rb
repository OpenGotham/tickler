class IntradayDocument
  include Ripple::Document
  property :symbol,       String, :presence => true
  property :company_name, String, :presence => true
  property :body,         Hash
end
