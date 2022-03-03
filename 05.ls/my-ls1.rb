# frozen_string_literal: true

NUMBER_OF_COLUMN = 3
NUMBER_OF_SPACE = 4

def main
  original_table_result = original_table
  display_table = adjust_table(original_table_result).transpose
  display_table.each do |column|
    column.each_with_index do |cell, number|
      print cell.to_s.ljust(build_space(original_table_result)[number])
    end
    print "\n"
  end
end

def original_table
  files = Dir.glob('*').sort
  return [] if files.empty?

  elements_per_column = (files.size.to_f / NUMBER_OF_COLUMN).ceil
  files.each_slice(elements_per_column).to_a
end

def adjust_table(table)
  max_size = table.map(&:size).max
  filled_table = table.map do |row|
    row.values_at(0...max_size)
  end
end

def build_space(table)
  table.map do |row|
    max_number_of_characters = row.max_by(&:size)
    max_number_of_characters.size + NUMBER_OF_SPACE
  end
end

main
