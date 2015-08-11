ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler/setup'
require 'chassis'
require 'minitest/autorun'
require 'rack/test'
require 'mocha/setup'

require 'stringio'
require 'pathname'
