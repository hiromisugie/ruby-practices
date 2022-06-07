# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  contents = read_contents
  display_lines_words_bytes(contents, options)
end

def display_lines_words_bytes(contents, options)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  contents.each do |content|
    line_count = content.values.flatten.count
    total_lines += line_count
    word_count = content.values.join.split(/\s+/).count
    total_words += word_count
    byte_count = content.values.join.length
    total_bytes += byte_count
    file = content.keys.join
    puts adjust_lines_words_bytes(line_count, word_count, byte_count, file, options)
  end

  return if contents.size == 1

  puts adjust_lines_words_bytes(total_lines, total_words, total_bytes, 'total', options)
end

def adjust_lines_words_bytes(lines, words, bytes, file_or_total, options)
  options['l'] ? lines.to_s.rjust(8) + " #{file_or_total}" : "#{lines.to_s.rjust(8)}#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)}" + " #{file_or_total}"
end

def read_contents
  if ARGV.empty?
    [{ '' => readlines }]
  else
    ARGV.map do |file|
      { file => File.open(file, &:readlines) }
    end
  end
end

main
