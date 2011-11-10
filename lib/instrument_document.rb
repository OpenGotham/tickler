class InstrumentDocument
  include Ripple::Document
  key_on   :symbol
  property :symbol,         String, :presence => true
  property :company_name,   String
  property :industry_group, String
  property :sector_group,   String
  property :short_interest, String
  property :current_share_outstanding, String
  property :current_share_in_float, String
  property :current_market_cap, String
  property :current_beta,   String
  property :eps_rating,     String
  property :relative_price_strength_rating, String
  property :industry_group_relative_strength_rating, String
  property :roe_rating,     String
  property :composite_rating, String
  property :moving_average, String
  property :volume_percent_change, String
  property :gross_margin_quarterly, Hash
  property :gross_margin_percent_change, Hash
  property :sales,          Hash
  property :sales_percent_change, Hash
  property :eps_quarterly,  Hash

  def self.save_from_array(pairs)
    raise "Wrong parameter type (Array expected, was #{pairs.class.name}.)" unless pairs.is_a?(Array)
    symbol      =  pairs.detect{|p| p[0] == 'Symbol'}
    latest_qtr  =  pairs.detect{|p| p[0] == 'LatestFiscalQTR'}
    latest_year =  pairs.detect{|p| p[0] == 'LatestFiscalYear'}
    raise "Missing required keys." unless symbol && latest_qtr && latest_year
    symbol      = symbol[1]
    latest_qtr  = latest_qtr[1]
    latest_year = latest_year[1]
    raise "Missing required keys." unless symbol && latest_qtr && latest_year

    record = self.find(symbol)
    if record.nil?
      record = self.new
      record.symbol         = symbol
      %w(gross_margin_quarterly gross_margin_percent_change sales sales_percent_change eps_quarterly).each do |hash|
        record.send("#{hash}=".to_sym, {})
      end
    end
    latest_fiscal_quarter = FiscalQuarter.new("FQ#{latest_qtr}_#{latest_year}")
    pairs.each do |pair|
      case pair[0]
      when 'CompanyName'
        record.company_name = pair[1]
      when 'IndustryGroup'
        record.industry_group = pair[1]
      when 'SectorGroup'
        record.sector_group = pair[1]
      when 'ShortInterest'
        record.short_interest = pair[1]
      when 'CurrentShareOutstanding'
        record.current_share_outstanding = pair[1]
      when 'CurrentShareInFloat'
        record.current_share_in_float = pair[1]
      when 'CurrentMarketCap'
        record.current_market_cap = pair[1]
      when 'CurrentBeta'
        record.current_beta = pair[1]
      when 'EPSRating'
        record.eps_rating = pair[1]
      when 'RelativePriceStrengthRating'
        record.relative_price_strength_rating = pair[1]
      when 'IndustryGroupRelativeStrengthRating'
        record.industry_group_relative_strength_rating = pair[1]
      when 'ROERating'
        record.roe_rating = pair[1]
      when 'CompositeRating'
        record.composite_rating = pair[1]
      when 'MovingAverage'
        record.moving_average = pair[1]
      when 'VolumePercentChange'
        record.volume_percent_change = pair[1]
      when /GrossMarginQuarterly/
        ago = pair[0].match(/GrossMarginQuarterly([\d]+)/)[1].to_i
        record.gross_margin_quarterly[latest_fiscal_quarter.aged(ago).to_s] = pair[1].to_f
      when /GrossMarginPercentChange/
        ago = pair[0].match(/GrossMarginPercentChange([\d]+)/)[1].to_i
        record.gross_margin_percent_change[latest_fiscal_quarter.aged(ago).to_s] = pair[1].to_f
      when /Sales([\d]+)/
        ago = pair[0].match(/Sales([\d]+)/)[1].to_i
        record.sales[latest_fiscal_quarter.aged(ago).to_s] = pair[1].to_f
      when /SalesPercentChange/
        ago = pair[0].match(/SalesPercentChange([\d]+)/)[1].to_i
        record.sales_percent_change[latest_fiscal_quarter.aged(ago).to_s] = pair[1].to_f
      when /EPSQuarterly/
        ago = pair[0].match(/EPSQuarterly([\d]+)/)[1].to_i
        record.eps_quarterly[latest_fiscal_quarter.aged(ago).to_s] = pair[1].to_f
      end
    end
    record.save
    record
  end
end
