require 'minitest/autorun'
require_relative '../lib/shot'

class ShotTest < Minitest::Test
  def test_shot
    shot = Shot.new('X')
    assert_equal 'X', shot.pins
    assert_equal 10, shot.score
  end
end