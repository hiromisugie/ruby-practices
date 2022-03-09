# frozen_string_literal: true

require 'optparse'

NUMBER_OF_COLUMN = 3
NUMBER_OF_SPACE = 4

def main
  columns = make_columns
  characters_per_column = count_characters_per_column(columns)
  rows = align_number_of_files_in_column(columns).transpose
  rows.each do |row|
    row_with_margin = row.map.with_index do |file_or_folder, number|
      file_or_folder.to_s.ljust(characters_per_column[number])
    end
    puts row_with_margin.join
  end
end

def make_columns
  files = Dir.glob('*')

  opt = OptionParser.new
  opt.on('-a', 'add File::FNM_DOTMATCH files') { files = Dir.glob('*', File::FNM_DOTMATCH) }
  opt.parse(ARGV)

  return [] if files.empty?

  elements_per_column = (files.size.to_f / NUMBER_OF_COLUMN).ceil
  files.sort.each_slice(elements_per_column).to_a
end

def align_number_of_files_in_column(columns)
  max_size = columns.map(&:size).max
  filled_table = columns.map do |column|
    column.values_at(0...max_size)
  end
end

def count_characters_per_column(columns)
  columns.map do |column|
    max_number_of_characters = column.max_by(&:size)
    max_number_of_characters.size + NUMBER_OF_SPACE
  end
end

main
