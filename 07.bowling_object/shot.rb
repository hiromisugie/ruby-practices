class Shot
  attr_reader :pins

  def initialize(pins)
    @pins = pins
  end

  def score
    return 10 if pins == 'X'
    pins.to_i
  end
end

shot = Shot.new('X')
shot.pins
shot.score