# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_shot, second_shot = nil, third_shot = nil)
    @first_shot = Shot.new(first_shot)
    @second_shot = Shot.new(second_shot)
    @third_shot = Shot.new(third_shot)
  end

  def sum_shots
    first_shot.to_i_pins + second_shot.to_i_pins + third_shot.to_i_pins
  end

  def strike?
    first_shot.to_i_pins == 10
  end

  def spare?
    !strike? && first_shot.to_i_pins + second_shot.to_i_pins == 10
  end
end
