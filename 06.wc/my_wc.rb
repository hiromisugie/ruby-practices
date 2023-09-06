# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('lwc')
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
    puts format_line(line_count, word_count, byte_count, file_name, options)
  end

  return if contents.size == 1

  puts format_line(total_lines, total_words, total_bytes, 'total', options)
end

def format_line(lines, words, bytes, file_or_total, options)
  # lオプションのみの場合
  # result = []
  # result << format_number(lines)
  # unless options['l']
  #   result << format_number(words)
  #   result << format_number(bytes)
  # end
  # result << " #{file_or_total}"
  # result.join

  # lオプション、wオプション、cオプションの場合
  result = []
  show_all = options.values.none?
  result << format_number(lines) if options['l'] || show_all
  result << format_number(words) if options['w'] || show_all
  result << format_number(bytes) if options['c'] || show_all
  result << " #{file_or_total}"
  result.join
end

def format_number(n)
  n.to_s.rjust(8)
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
