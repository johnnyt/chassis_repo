require_relative '../test_helper'

class NullRepoTest < Minitest::Test
  Person = Struct.new :name do
    attr_accessor :id
  end

  attr_reader :repo

  def setup
    @repo = Chassis::NullRepo.new
  end

  def test_create_sets_the_id
    person = Person.new 'ahawkins'
    repo.create person

    assert person.id, "Repo must set the ID after creating"
  end

  def test_all_returns_an_empty_array
    assert_equal [], repo.all(Person)
  end

  def test_implements_required_interface
    assert_respond_to repo, :update
    assert_respond_to repo, :delete
    assert_respond_to repo, :find
    assert_respond_to repo, :all
    assert_respond_to repo, :count
    assert_respond_to repo, :first
    assert_respond_to repo, :last
    assert_respond_to repo, :sample
    assert_respond_to repo, :query
    assert_respond_to repo, :graph_query
    assert_respond_to repo, :graph_query
    assert_respond_to repo, :clear
  end

  def test_query_returns_empty_array
    assert_equal [ ], repo.query(Person, :selector)
  end

  def test_graph_query_returns_empty_array
    assert_equal [ ], repo.graph_query(Person, :selector)
  end

  def test_count_returns_no
    assert_equal 0, repo.count(Person)
  end

  def test_first_and_last_return_nil
    assert_nil repo.first(Person)
    assert_nil repo.last(Person)
  end
end
