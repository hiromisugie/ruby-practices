# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'

NUMBER_OF_COLUMN = 3
NUMBER_OF_SPACE = 4

def main
  options = ARGV.getopts('l')
  files = Dir.glob('*').sort
  if options['l']
    l_option(files)
  else
    other_than_l_option(files)
  end
end

def l_option(files)
  display_total_block_size(files)
  display_files_information(files)
end

def display_total_block_size(files)
  total_block_size = 0
  files.each do |file|
    total_block_size += File.lstat(file).blocks
  end
  puts "total #{total_block_size}"
end

def display_files_information(files)
  files.map do |file|
    stat = File.lstat(file)

    filetype_short = make_filetype(stat.ftype)

    filemode = stat.mode.to_s(8).rjust(6, '0')
    filemode_owner = make_filemode(filemode[3].to_i)
    filemode_owned_group = make_filemode(filemode[4].to_i)
    filemode_other_users = make_filemode(filemode[5].to_i)
    permissions = "#{filemode_owner}#{filemode_owned_group}#{filemode_other_users}" # 式展開が長くなりすぎるのでまとめた

    hardlink = stat.nlink
    owner_name = Etc.getpwuid(stat.uid).name
    group_name = Etc.getgrgid(stat.gid).name

    filesize = stat.size.to_s.rjust(make_length_of_max_size_file(files))

    month = stat.mtime.strftime('%m').to_i.to_s.rjust(2)
    day = stat.mtime.strftime('%e')
    time = stat.mtime.strftime('%H:%M')
    time_stamp = "#{month} #{day} #{time}" # 式展開が長くなりすぎるのでまとめた

    link_source_of_symbolic_link = " -> #{File.realpath(file).split('/')[-1]}" if File.symlink?(file)

    puts "#{filetype_short}#{permissions}  #{hardlink} #{owner_name}  #{group_name}  #{filesize} #{time_stamp} #{file}#{link_source_of_symbolic_link}"
  end
end

def make_filetype(filetype)
  filetypes = {
    'file' => '-',
    'directory' => 'd',
    'link' => 'l'
  }
  filetypes[filetype]
end

def make_filemode(decimal_number)
  permission = {
    0 => '---',
    1 => '--x',
    2 => '-w-',
    3 => '-wx',
    4 => 'r--',
    5 => 'r-x',
    6 => 'rw-',
    7 => 'rwx'
  }
  permission[decimal_number]
end

def make_length_of_max_size_file(files)
  length_of_files = files.map do |file|
    File.size(file).to_s.length
  end
  length_of_files.max
end

def other_than_l_option(files)
  columns = make_columns(files)
  characters_per_column = count_characters_per_column(columns)
  rows = align_number_of_files_in_column(columns).transpose
  rows.each do |row|
    row_with_margin = row.map.with_index do |file_or_folder, number|
      file_or_folder.to_s.ljust(characters_per_column[number])
    end
    puts row_with_margin.join
  end
end

def make_columns(files)
  return [] if files.empty?

  elements_per_column = (files.size.to_f / NUMBER_OF_COLUMN).ceil
  files.each_slice(elements_per_column).to_a
end

def align_number_of_files_in_column(columns)
  max_size = columns.map(&:size).max
  columns.map do |column|
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
