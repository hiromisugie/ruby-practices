# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  contents = read_contents
  display_result(contents, options)
end

def display_result(contents, options)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  contents.each do |file_name, content|
    line_count = content.count
    total_lines += line_count
    word_count = content.join.split(/\s+/).count
    total_words += word_count
    byte_count = content.join.length
    total_bytes += byte_count
    puts adjust_lines_words_bytes(line_count, word_count, byte_count, file_name, options)
  end

  return if contents.size == 1

  puts adjust_lines_words_bytes(total_lines, total_words, total_bytes, 'total', options)
end

def adjust_lines_words_bytes(lines, words, bytes, file_or_total, options)
  result = []
  result << format_number(lines)
  unless options['l']
    result << format_number(words)
    result << format_number(bytes)
  end
  result << " #{file_or_total}"
  result.join

  # lオプションとwオプションの場合は以下？
  # result = []
  # result << format_number(lines) if options['l'] || options.empty?
  # result << format_number(words) if options['w'] || options.empty?
  # result << format_number(bytes) if options['c'] || options.empty?
  # result << " #{file_or_total}"
  # result.join
end

def format_number(integer)
  integer.to_s.rjust(8)
end

def read_contents
  if ARGV.empty?
    { '' => readlines }
  else
    ARGV.to_h do |file|
      [file, File.readlines(file)]
    end
  end
end

main
