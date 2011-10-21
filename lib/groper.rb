require 'nokogiri'

class Groper
  attr_reader :urls

  def initialize
    @urls = ["Estimizer_Daily_A.xml","Estimizer_Intraday_A.xml"]
  end

  def perform
    # file 1
    filename = File.expand_path(File.join('..','..','tmp',Time.now.strftime("%Y%d%m%H%M%L.xml")), __FILE__)
    `wget -O #{filename} #{self.urls[0]}`
    parse(IntradayParser, filename)
    File.unlink(filename)

    # file 2
    filename = File.expand_path(File.join('..','..','tmp',Time.now.strftime("%Y%d%m%H%M%L.xml")), __FILE__)
    `wget -O #{filename} #{self.url[1]}`
    parse(DailyParser, filename)
    File.unlink(filename)
  end

  def parse(klass, filename)
    raise "Unknown parser!" unless [IntradayParser, DailyParser].include?(klass)
    parser = Nokogiri::XML::SAX::Parser.new(klass.new)
    parser.parse(File.read(filename))
  end
end
