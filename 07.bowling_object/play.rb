# frozen_string_literal: true

require_relative 'lib/game'

inputs = ARGV[0]
adjust_inputs = Game.adjust_inputs(inputs)
game = Game.new(*adjust_inputs)
puts game.calculate_scores
