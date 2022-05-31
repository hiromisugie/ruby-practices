# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  contents = read_contents
  lines = count_lines(contents)
  words = count_words(contents)
  bytes = count_bytes(contents)

  if standard_input?
    display_standard_input(options, lines, words, bytes)
  else
    display_files_input(options, contents, lines, words, bytes)
  end
end

def display_standard_input(options, lines, words, bytes)
  puts options['l'] ? adjust_lines_l_option(lines) : adjust_lines_words_bytes(lines, words, bytes)
end

def display_files_input(options, contents, lines, words, bytes)
  contents.zip(ARGV).each do |content, file|
    each_lines = count_lines(content)
    each_words = count_words(content)
    each_bytes = count_bytes(content)
    puts options['l'] ? adjust_lines_l_option(each_lines) + " #{file}" : adjust_lines_words_bytes(each_lines, each_words, each_bytes) + " #{file}"
  end

  return if contents.size == 1
  puts options['l'] ? adjust_lines_l_option(lines) + " total" : adjust_lines_words_bytes(lines, words, bytes) + " total"
end

def adjust_lines_words_bytes(lines, words, bytes)
  "#{lines.to_s.rjust(8)}#{words.to_s.rjust(8)}#{bytes.to_s.rjust(8)}"
end

def adjust_lines_l_option(lines)
  "#{lines.to_s.rjust(8)}"
end

def count_lines(contents)
  contents.flatten.count
end

def count_words(contents)
  contents.join.split(/\s+/).count
end

def count_bytes(contents)
  contents.join.length
end

def read_contents
  if standard_input?
    readlines
  else
    ARGV.map do |file|
      File.open(file, &:readlines)
    end
  end
end

def standard_input?
  ARGV.empty?
end

main
