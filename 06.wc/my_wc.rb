# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l')
  contents = read_contents

  if read_files.empty?
    display_standard_input(contents, options)
  else
    display_files_input(contents, options)
  end
end

def display_standard_input(contents, options)
  lines = count_lines(contents).to_s.rjust(8)
  words = count_words(contents).to_s.rjust(8)
  bytes = count_bytes(contents).to_s.rjust(8)
  puts options['l'] ? lines.to_s : "#{lines}#{words}#{bytes}"
end

def display_files_input(contents, options)
  contents.zip(read_files).each do |content, file|
    lines = count_lines(content).to_s.rjust(8)
    words = count_words(content).to_s.rjust(8)
    bytes = count_bytes(content).to_s.rjust(8)
    puts options['l'] ? "#{lines} #{file}" : "#{lines}#{words}#{bytes} #{file}"
  end

  # ARGV[1]がnil、つまりファイルの指定が1つだったらreturnで、2つ以上だったら以下も実行してtotal行を表示
  return if ARGV[1].nil?

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
  if read_files.empty? # read_filesつまりARGVが無い場合は入力モードにする
    readlines
  else
    read_files.map do |file|
      File.open(file, &:readlines)
    end
  end
end

def read_files
  ARGV
end

main
