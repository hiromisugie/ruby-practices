# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :frames

  def initialize(*frames)
    @frames = frames.map { |frame| Frame.new(*frame) }
  end

  def calculate_scores
    total_scores = 0

    frames.each_with_index do |frame, index|
      total_scores += frame.sum_shots

      if frame.strike? && index < 9
        total_scores += add_strike_bonus(index)
      elsif frame.spare? && index < 9
        total_scores += add_spare_bonus(index)
      end
    end

    total_scores
  end
end

private

def array_inputs(inputs = ARGV[0])
  inputs.split(',').map(&:to_s)
end

def adjust_inputs
  scores = []

  array_inputs.each do |shot|
    scores << shot
    scores << '0' if shot == 'X' && scores.size < 18
  end

  adjust_inputs = scores.each_slice(2).to_a

  if adjust_inputs.size == 11
    adjust_inputs[9] << adjust_inputs[10][0]
    adjust_inputs.delete_at(10)
  end

  adjust_inputs
end

def add_strike_bonus(index)
  next_frame = frames[index + 1]

  bonus = next_frame.sum_shots
  bonus += frames[index + 2].first_shot.to_i_pins if next_frame.strike? && index < 8
  bonus -= next_frame.third_shot.to_i_pins if index == 8

  bonus
end

def add_spare_bonus(index)
  next_frame = frames[index + 1]

  next_frame.first_shot.to_i_pins
end

game = Game.new(*adjust_inputs)
puts game.calculate_scores
