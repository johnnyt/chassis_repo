require 'rubygems'

require 'interchange'
require 'tnt'
require 'lift'
require 'logger-better'
require 'prox'

module Chassis
  Proxy = Prox
  class << self
    def stream
      @stream
    end

    def stream=(stream)
      @stream = stream
    end
  end
end

require_relative 'chassis/hash_utils'
require_relative 'chassis/string_utils'
require_relative 'chassis/array_utils'
require_relative 'chassis/error'
require_relative 'chassis/logger'
require_relative 'chassis/persistence'
require_relative 'chassis/initializable'
require_relative 'chassis/repo'
require_relative 'chassis/delegate'

Chassis.repo.register :memory, Chassis::MemoryRepo.new
Chassis.repo.register :null, Chassis::NullRepo.new
Chassis.repo.use :memory
