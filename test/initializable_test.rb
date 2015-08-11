require_relative 'test_helper'

class InitializableTest < Minitest::Test
  def test_uses_lift
    assert_equal Lift, Chassis::Initializable
  end
end
