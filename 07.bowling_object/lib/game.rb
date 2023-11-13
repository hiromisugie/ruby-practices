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
      total_scores += frame.frame_point

      if frame.strike? && index < 9
        total_scores += strike_bonus(index)
      elsif frame.spare? && index < 9
        total_scores += spare_bonus(index)
      end
    end

    total_scores
  end

  private

  def strike_bonus(index)
    next_frame = frames[index + 1]

    bonus = next_frame.frame_point
    bonus += frames[index + 2].first_shot.score if next_frame.strike? && index < 8
    bonus -= next_frame.third_shot.score if index == 8

    bonus
  end

  def spare_bonus(index)
    next_frame = frames[index + 1]

    next_frame.first_shot.score
  end
end

def adjust_inputs(inputs)
  scores = []

  inputs.split(',').map(&:to_s).each do |shot|
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

inputs = ARGV[0]
game = Game.new(*adjust_inputs(inputs))
puts game.calculate_scores
