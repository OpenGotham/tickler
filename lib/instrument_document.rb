class InstrumentDocument
  include Ripple::Document
  key_on   :symbol
  property :symbol,        String, :presence => true
  property :company_name,  String
  property :sales,         Hash
  property :eps_quarterly, Hash
      case pair[0]
      when 'CompanyName'
 :company_name
 = pair[1]
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
      when /Sales/
        ago = pair[0].match(/Sales([\d]+)/)[1].to_i
        record.sales[latest_fiscal_quarter.aged(ago).to_s] = pair[1].to_f
      when /SalesPercentChange/
        ago = pair[0].match(/SalesPercentChange([\d]+)/)[1].to_i
        record.sales_percent_change[latest_fiscal_quarter.aged(ago).to_s] = pair[1].to_f
      when /EPSQuarterly/
        ago = pair[0].match(/EPSQuarterly([\d]+)/)[1].to_i
        record.eps_quarterly[latest_fiscal_quarter.aged(ago).to_s] = pair[1].to_f
      end

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
      record.sales          = {}
      record.eps_quarterly  = {}
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
      when /Sales/
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
=begin
FQ3 2011

<CompanyName>Alliance Financial Corp</CompanyName>
<EPSQuarterly1>0.66</EPSQuarterly1>
<EPSQuarterly2>0.73</EPSQuarterly2>
<EPSQuarterly3>0.70</EPSQuarterly3>
<EPSQuarterly4>0.59</EPSQuarterly4>
<EPSQuarterly5>0.66</EPSQuarterly5>
<EPSQuarterly6>0.64</EPSQuarterly6>
<EPSQuarterly7>0.59</EPSQuarterly7>
<EPSQuarterly8>0.75</EPSQuarterly8>
<EPSQuarterly9>0.64</EPSQuarterly9><EPSQuarterly10>0.37</EPSQuarterly10><EPSQuarterly11>0.57</EPSQuarterly11>
<EPSQuarterly12>0.51</EPSQuarterly12><EPSQuarterly13>0.65</EPSQuarterly13><EPSQuarterly14>0.62</EPSQuarterly14>
<EPSQuarterly15>0.44</EPSQuarterly15><EPSQuarterly16>0.51</EPSQuarterly16><EPSQuarterly17>0.51</EPSQuarterly17>

<EPSPercentChange1>0.00</EPSPercentChange1>
<EPSPercentChange2>14.06</EPSPercentChange2>
<EPSPercentChange3>18.64</EPSPercentChange3>
<EPSPercentChange4>-21.33</EPSPercentChange4>
<EPSPercentChange5>3.12</EPSPercentChange5>
<EPSPercentChange6>72.97</EPSPercentChange6><EPSPercentChange7>3.50</EPSPercentChange7><EPSPercentChange8>47.05</EPSPercentChange8><EP
SPercentChange9>-1.53</EPSPercentChange9><EPSPercentChange10>-40.32</EPSPercentChange10><EPSPercentChange11>29.54</EPSPercentChange11><EPSPercentChange12>0.00</EPSPercentCh
ange12><EPSPercentChange13>27.45</EPSPercentChange13><EPSPercentChange14>29.16</EPSPercentChange14><EPSPercentChange15>-10.20</EPSPercentChange15><EPSPercentChange16>18.60</EPSPercentChange16>
<EPSPercentChange17>0.00</EPSPercentChange17>
<Sales1>19.98</Sales1>
<Sales2>18.93</Sales2>
<Sales3>18.85</Sales3>
<Sales4>20.35</Sales4>
<Sales5>20.24</Sales5><Sales6>20.24</Sales6><Sales7>20.02</Sales7><Sales8>21.99</Sales8><Sales9>20.89</Sales9><Sales10>20.64</Sales10><Sales11>21.25</Sales11><Sales12>21.45</Sales12><Sales13>
21.87</Sales13><Sales14>22.27</Sales14><Sales15>22.74</Sales15><Sales16>23.68</Sales16><Sales17>23.46</Sales17><SalesPercentChange1>-1.29</SalesPercentChange1><SalesPercent
Change2>-6.48</SalesPercentChange2><SalesPercentChange3>-5.85</SalesPercentChange3><SalesPercentChange4>-7.46</SalesPercentChange4><SalesPercentChange5>-3.12</SalesPercentC
hange5><SalesPercentChange6>-1.94</SalesPercentChange6><SalesPercentChange7>-5.79</SalesPercentChange7><SalesPercentChange8>2.51</SalesPercentChange8><SalesPercentChange9>-
4.49</SalesPercentChange9><SalesPercentChange10>-7.32</SalesPercentChange10><SalesPercentChange11>-6.56</SalesPercentChange11><SalesPercentChange12>-9.42</SalesPercentChang
e12><SalesPercentChange13>-6.78</SalesPercentChange13><SalesPercentChange14>-2.29</SalesPercentChange14><SalesPercentChange15>1.51</SalesPercentChange15><SalesPercentChange
16>3.36</SalesPercentChange16><SalesPercentChange17>28.61</SalesPercentChange17>
<LatestFiscalQTR>3</LatestFiscalQTR>
<LatestFiscalYear>2011</LatestFiscalYear>
</RecordDetails
><RecordDetails xmlns:Estimize_Intraday="http://apreceive1.williamoneil.com/estimize/"><Symbol>CAKE</Symbol><CompanyName>Cheesecake Factory Inc</CompanyName><EPSQuarterly1>
0.36</EPSQuarterly1><EPSQuarterly2>0.42</EPSQuarte
sMarginPercentChange5>end
