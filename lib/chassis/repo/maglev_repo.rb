module Chassis
  class MaglevRepo < BaseRepo
    class MaglevMap
      def initialize store
        @store = store
      end

      def set(record)
        record_map(record)[record.id] = record
        Maglev.commit
      end

      def get(klass, id)
        class_map(klass).fetch id do
          fail RecordNotFoundError.new(klass, id)
        end
      end

      def delete(record)
        record_map(record).delete record.id
        Maglev.commit
      end

      def all(klass)
        class_map(klass).values
      end

      def clear
        store.clear
        Maglev.commit
      end

      private
      def store
        @store
      end

      def class_map(klass)
        store[klass] ||= { }
      end

      def record_map(record)
        class_map record.class
      end
    end

    def initialize store
      @map = MaglevMap.new store
    end
  end
end
