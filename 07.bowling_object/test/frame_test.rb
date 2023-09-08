# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'

class FrameTest < Minitest::Test
  def test_frame
    frame1 = Frame.new(1, 9)
    assert_equal 10, frame1.sum_pins
    assert_equal true, frame1.is_spare?
    frame2 = Frame.new('X')
    assert_equal 10, frame2.sum_pins
    assert_equal true, frame2.is_strike?
    frame3 = Frame.new(1, 5)
    assert_equal 6, frame3.sum_pins
    assert_equal false, frame3.is_strike?
    assert_equal false, frame3.is_spare?
  end
end
