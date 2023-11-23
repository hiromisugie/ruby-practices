# frozen_string_literal: true

class Shot
  attr_reader :pins

  def initialize(pins)
    @pins = pins
  end

  def score
    pins == 'X' ? 10 : pins.to_i
  end
end
