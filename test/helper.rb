require 'rubygems'
require 'webmachine'
require 'nokogiri'
require 'minitest/unit'
require 'minitest/mock'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require File.expand_path('../../lib/funny_bone', __FILE__)
require File.expand_path('../../lib/groper', __FILE__)

MiniTest::Unit.autorun
