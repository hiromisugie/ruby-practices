#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |shot|
  if shot == 'X'
    shots << 10
    shots << 0
  else
    shots << shot.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  frames << shot
end

point = 0
frames.each_with_index do |frame, n|
  point +=
    if [9, 10, 11].include?(n)
      frame.sum
    elsif frames[n][0] == 10
      if frames[n + 1][0] == 10
        frame.sum + frames[n + 1][0] + frames[n + 2][0]
      else
        frame.sum + frames[n + 1][0] + frames[n + 1][1]
      end
    elsif frame.sum == 10
      frame.sum + frames[n + 1][0]
    else
      frame.sum
    end
end
puts point

# hoge