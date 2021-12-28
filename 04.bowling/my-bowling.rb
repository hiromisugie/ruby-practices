#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split( ',')
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
  if n == 9 || n == 10 || n == 11
    point += frame.sum
  elsif frames[n][0] == 10
    if frames[n + 1][0] == 10
      point += frame.sum + frames[n + 1][0] + frames[n + 2][0]
    else
      point += frame.sum + frames[n + 1][0] + frames[n + 1][1]
    end
  elsif frame.sum == 10
    point += frame.sum + frames[n + 1][0]
  else
    point += frame.sum
  end
end
puts point