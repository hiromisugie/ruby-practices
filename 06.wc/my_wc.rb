# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  contents = read_contents

  if standart_input?
    display_standard_input(contents, options)
  else
    display_files_input(contents, options)
  end
end

def display_standard_input(contents, options)
  lines = count_lines(contents).to_s.rjust(8)
  words = count_words(contents).to_s.rjust(8)
  bytes = count_bytes(contents).to_s.rjust(8)
  puts options['l'] ? lines : "#{lines}#{words}#{bytes}"
end

def display_files_input(contents, options)
  contents.zip(ARGV).each do |content, file|
    lines = count_lines(content).to_s.rjust(8)
    words = count_words(content).to_s.rjust(8)
    bytes = count_bytes(content).to_s.rjust(8)
    puts options['l'] ? "#{lines} #{file}" : "#{lines}#{words}#{bytes} #{file}"
  end

  return if contents.size == 1

  total_lines = 0
  total_words = 0
  total_bytes = 0
  contents.each do |content|
    lines = count_lines(content)
    words = count_words(content)
    bytes = count_bytes(content)
    total_lines += lines
    total_words += words
    total_bytes += bytes
  end
  puts options['l'] ? "#{total_lines.to_s.rjust(8)} total" : "#{total_lines.to_s.rjust(8)}#{total_words.to_s.rjust(8)}#{total_bytes.to_s.rjust(8)} total"
end

def count_lines(contents)
  contents.count
end

def count_words(contents)
  contents.join.split(/\s+/).count
end

def count_bytes(contents)
  contents.join.length
end

def read_contents
  if standart_input?
    readlines
  else
    ARGV.map do |file|
      File.open(file, &:readlines)
    end
  end
end

def standart_input?
  ARGV.empty?
end

main
