require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def test_game
    game1 = Game.new(['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X', 'X', 'X'])
    assert_equal 120, game1.points
    game2 = Game.new([1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0])
    assert_equal 10, game2.points
  end
end