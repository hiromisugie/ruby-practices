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
  contents.each do |key, value|
    line_count = value.count
    total_lines += line_count
    word_count = value.join.split(/\s+/).count
    total_words += word_count
    byte_count = value.join.length
    total_bytes += byte_count
    puts adjust_lines_words_bytes(line_count, word_count, byte_count, key, options)
  end

  return if contents.size == 1

  puts adjust_lines_words_bytes(total_lines, total_words, total_bytes, 'total', options)
end

def adjust_lines_words_bytes(lines, words, bytes, file_or_total, options)
  if options['l']
    "#{apply_to_s_rjust(lines)} #{file_or_total}"
  else
    "#{apply_to_s_rjust(lines)}#{apply_to_s_rjust(words)}#{apply_to_s_rjust(bytes)} #{file_or_total}"
  end
end

def apply_to_s_rjust(integer)
  integer.to_s.rjust(8)
end

def read_contents
  if ARGV.empty?
    { '' => readlines }
  else
    hash = {}
    ARGV.each do |file|
      File.open(file) do |f|
        hash[f.path] = f.readlines
      end
    end
    hash
  end
end

main
