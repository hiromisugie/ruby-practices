class Shot
  attr_reader :pins

  def initialize(pins)
    @pins = pins
  end

  def to_i_pins
    return 10 if pins == 'X'
    pins.to_i
  end
end
