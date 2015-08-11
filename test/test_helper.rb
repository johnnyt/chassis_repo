ENV["RACK_ENV"] = "test"

require "rubygems"
require "bundler/setup"
require "chassis"
require "minitest/autorun"
require "minitest/reporters"
require "mocha/setup"

require "stringio"
require "pathname"

Minitest::Reporters.use!
