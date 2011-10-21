require 'nokogiri'

class Groper
  attr_reader :url

  def initialize
    @url = "Estimizer.xml"
  end

  def perform
    filename = File.expand_path(File.join('..','..','tmp',Time.now.strftime("%Y%d%m%H%M%L.xml")), __FILE__)
    `wget -O #{filename} #{self.url}`
    store(filename)
    File.unlink(filename)
  end

  def parse(klass, filename)
    raise "Unknown parser!" unless [IntradayParser, DailyParser].include?(klass)
    parser = Nokogiri::XML::SAX::Parser.new(klass.new)
    parser.parse(File.read(filename))
  end
end
