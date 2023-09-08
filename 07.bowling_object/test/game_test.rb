require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def test_game
    game1 = Game.new([1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0], [1, 0])
    assert_equal 10, game1.points
    game2 = Game.new(['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X', 'X', 'X'])
    assert_equal 300, game2.points
    game3 = Game.new(['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X', 'X', 5])
    assert_equal 295, game3.points
    game3 = Game.new(['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], ['X'], [5, 0], ['X', 'X', 'X'])
    assert_equal 255, game3.points
  end
end