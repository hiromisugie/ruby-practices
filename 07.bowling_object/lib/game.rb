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

      if frame.is_strike? && index < 9
        total_points += strike_bonus(index)
      elsif frame.is_spare? && index < 9
        total_points += spare_bonus(index)
      end
    end

    total_points
  end
end

private

def strike_bonus(index)
  next_frame = frames[index + 1]

  bonus = next_frame.sum_pins

  if next_frame.is_strike? && index < 8
    bonus += frames[index + 2].first_shot.to_i_pins
  elsif next_frame.is_strike? && index == 8
    bonus -= next_frame.third_shot.to_i_pins
  end

  bonus
end

def spare_bonus(index)
  next_frame = frames[index + 1]

  next_frame.first_shot.to_i_pins
end
