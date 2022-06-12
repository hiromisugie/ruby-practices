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
  ans = +''
  ans << format_number(lines)
  ans << "#{format_number(words)}#{format_number(bytes)}" unless options['l']
  ans << " #{file_or_total}"

  # lオプションとwオプションの場合は以下？
  # ans = String.new()
  # ans << "#{format_number(lines)}" if options['l']
  # ans << "#{format_number(words)}" if options['w']
  # ans << "#{format_number(lines)}#{format_number(words)}#{format_number(bytes)}" unless (options['l'] || options['w'])
  # ans << " #{file_or_total}"
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
