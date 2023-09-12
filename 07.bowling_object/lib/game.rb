# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :frames

  def initialize(*frames)
    @frames = frames.map { |frame| Frame.new(*frame) }
  end

  def points
    total_points = 0

    frames.each_with_index do |frame, index|
      total_points += frame.sum_pins

      if frame.strike? && index < 9
        total_points += strike_bonus(index)
      elsif frame.spare? && index < 9
        total_points += spare_bonus(index)
      end
    end

    total_points
  end
end

private

def arrayed_scores(input_scores = ARGV[0])
  input_scores.split(',').map(&:to_s)
end

def adjusted_scores
  scores = []

  arrayed_scores.each do |shot|
    scores << shot
    scores << '0' if shot == 'X' && scores.size < 18
  end

  adjusted_scores = scores.each_slice(2).to_a

  if adjusted_scores.size == 11
    adjusted_scores[9] << adjusted_scores[10][0]
    adjusted_scores.delete_at(10)
  end

  adjusted_scores
end

def strike_bonus(index)
  next_frame = frames[index + 1]

  bonus = next_frame.sum_pins
  bonus += frames[index + 2].first_shot.to_i_pins if next_frame.strike? && index < 8
  bonus -= next_frame.third_shot.to_i_pins if index == 8

  bonus
end

def spare_bonus(index)
  next_frame = frames[index + 1]

  next_frame.first_shot.to_i_pins
end

game = Game.new(*adjusted_scores)
puts game.points
