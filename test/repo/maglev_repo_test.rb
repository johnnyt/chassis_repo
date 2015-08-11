require_relative '../test_helper'
require_relative 'repo_tests'

class MaglevRepoTest < Minitest::Test
  ROOT_KEY = :chassis_test

  class TestRepo < Chassis::MaglevRepo
    def query_person_named(klass, selector)
      all(klass).select do |person|
        person.name == selector.name
      end
    end

    def graph_query_person_named(klass, selector)
      all(klass).select do |person|
        person.name == selector.name
      end
    end
  end

  include RepoTests

  def setup
    Maglev[ROOT_KEY] = {}
    Maglev.commit
    @repo = TestRepo.new Maglev[ROOT_KEY]
    super
  end

  def teardown
    Maglev.root.delete ROOT_KEY
    Maglev.commit
  end

  def test_map_store_is_committed
    map = @repo.send :map
    store = map.send :store
    refute store.nil?
    assert store.committed?
  end

  def test_persistent_crud_operations
    person = Person.new 'ahawkins'

    refute person.committed?, "brand new custom objects should be transient"
    repo.create person
    assert person.committed?, "repo must commit saved objects"

    # repo.delete(person)
    # refute person.committed?, "repo must delete committed objects"
  end
end
