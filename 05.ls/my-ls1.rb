# frozen_string_literal: true

number_of_row = 3
files = Dir.glob('*').sort
number_of_elements_per_row = (files.length.to_f / number_of_row).ceil
@files_table =
  if files == []
    []
  else
    files.each_slice(number_of_elements_per_row).to_a
  end

def adjust_table
  max_size = @files_table.map(&:size).max
  @files_table.map! do |n|
    n.values_at(0...max_size)
  end
  @files_table.each do |n|
    n.map! { |x| x.nil? ? '' : x }
  end
end

def build_space
  @files_table.map do |n|
    maximum_number_of_characters = n.max_by(&:length)
    maximum_number_of_characters.length + 4
  end
end

def display_ls
  display_table = adjust_table.transpose
  display_table.each do |column|
    column.each_with_index do |n, number|
      print n.ljust(build_space[number])
    end
    print "\n"
  end
end

display_ls
