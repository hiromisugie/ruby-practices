# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_pins, second_pins = nil, third_pins = nil)
    @first_shot = Shot.new(first_pins)
    @second_shot = Shot.new(second_pins)
    @third_shot = Shot.new(third_pins)
  end

  def sum_pins
    first_shot.to_i_pins + second_shot.to_i_pins + third_shot.to_i_pins
  end

  def strike?
    first_shot.to_i_pins == 10
  end

  def spare?
    first_shot.to_i_pins != 10 && first_shot.to_i_pins + second_shot.to_i_pins == 10
  end
end
