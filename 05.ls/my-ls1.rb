# frozen_string_literal: true

NUMBER_OF_COLUMN = 3

def main
  display_table = adjust_table.transpose
  display_table.each do |column|
    column.each_with_index do |cell, number|
      print cell.ljust(build_space[number])
    end
    print "\n"
  end
end

def adjust_table
  max_size = original_table.map(&:size).max
  original_table.map! do |row|
    row.values_at(0...max_size)
  end
  original_table.each do |row|
    row.map! { |x| x.nil? ? '' : x }
  end
end

def build_space
  original_table.map do |row|
    max_number_of_characters = row.max_by(&:size)
    max_number_of_characters.size + 4
  end
end

def original_table
  files = Dir.glob('*').sort
  elements_per_column = (files.size.to_f / NUMBER_OF_COLUMN).ceil
  if files == []
    []
  else
    files.each_slice(elements_per_column).to_a
  end
end

main
