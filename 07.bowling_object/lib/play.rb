# frozen_string_literal: true

require_relative 'game'

inputs = ARGV[0]
game = Game.new(*adjust_inputs(inputs))
puts game.calculate_scores
