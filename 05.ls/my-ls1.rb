# frozen_string_literal: true

NUMBER_OF_COLUMN = 3
NUMBER_OF_SPACE = 4

def main
  columns = make_columns
  display_table = align_number_of_files_in_column(columns).transpose
  display_table.each do |column|
    hoge = column.map.with_index do |cell, number|
      cell.to_s.ljust(count_characters_per_column(columns)[number])
    end
    puts hoge.join
  end
end

def make_columns
  files = Dir.glob('*').sort
  return [] if files.empty?

  elements_per_column = (files.size.to_f / NUMBER_OF_COLUMN).ceil
  files.each_slice(elements_per_column).to_a
end

def align_number_of_files_in_column(columns)
  max_size = columns.map(&:size).max
  filled_table = columns.map do |column|
    column.values_at(0...max_size)
  end
end

def count_characters_per_column(columns)
  columns.map do |row|
    max_number_of_characters = row.max_by(&:size)
    max_number_of_characters.size + NUMBER_OF_SPACE
  end
end

main
