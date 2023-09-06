require 'minitest/autorun'
require_relative '../lib/frame'

class FrameTest < Minitest::Test
  def test_frame
    frame = Frame.new('1', '9')
    assert_equal 10, frame.score
  end
end