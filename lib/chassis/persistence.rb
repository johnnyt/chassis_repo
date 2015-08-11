module Chassis
  module Persistence
    module ClassMethods
      def create(*args, &block)
        record = new(*args, &block)
        record.save
        record
      end

      def repo
        begin
          @repo ||= StringUtils.constantize "#{name}Repo"
        rescue NameError
          fail "#{name}Repo not defined! Define this method to specify a different repo"
        end
      end
    end

    class << self
      def included(base)
        base.class_eval do
          include Initializable
          #include Equalizer.new(:id)

          # Compare the object with other object for equality
          #
          # @example
          #   object.eql?(other)  # => true or false
          #
          # @param [Object] other
          #   the other object to compare with
          #
          # @return [Boolean]
          #
          # @api public
          def eql?(other)
            instance_of?(other.class) && id.eql?(other.id)
          end

          # Compare the object with other object for equivalency
          #
          # @example
          #   object == other  # => true or false
          #
          # @param [Object] other
          #   the other object to compare with
          #
          # @return [Boolean]
          #
          # @api public
          def ==(other)
            other = coerce(other).first if respond_to?(:coerce, true)
            other.kind_of?(self.class) && id == other.id
          end

          def hash
            id.hash
          end

          attr_accessor :id
        end

        base.extend ClassMethods
      end
    end

    def save
      yield self if block_given?
      repo.save self
    end

    def delete
      repo.delete self
    end

    def new_record?
      id.nil?
    end

    def repo
      self.class.repo
    end
  end
end
