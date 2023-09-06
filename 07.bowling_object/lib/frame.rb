require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_pins, second_pins, third_pins = nil)
    @first_shot = Shot.new(first_pins)
    @second_shot = Shot.new(second_pins)
    @third_shot = Shot.new(third_pins)
  end

  def score
    first_shot.score + second_shot.score + third_shot.score
  end
end
