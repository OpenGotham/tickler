require 'webmachine'
require 'nokogiri'
require 'ripple'
require File.expand_path('../intraday_document', __FILE__)
require File.expand_path('../intraday_parser', __FILE__)
require File.expand_path('../daily_document', __FILE__)
require File.expand_path('../daily_parser', __FILE__)
require File.expand_path('../funny_bone', __FILE__)
require File.expand_path('../groper', __FILE__)

Webmachine::Dispatcher.add_route(['tickle'], FunnyBone)
Webmachine.run
