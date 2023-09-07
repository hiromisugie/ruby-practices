require 'minitest/autorun'
require_relative '../lib/shot'

class ShotTest < Minitest::Test
  def test_shot
    shot1 = Shot.new(5)
    assert_equal 5, shot1.to_i_pins
    shot2 = Shot.new('X')
    assert_equal 10, shot2.to_i_pins
  end
end