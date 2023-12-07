# frozen_string_literal: true

require_relative 'file_info'

NUMBER_OF_COLUMN = 3
NUMBER_OF_SPACE = 4

class FileDisplay
  def initialize(file_list, options)
    @file_list = file_list
    @options = options
  end

  def show
    @options['l'] ? show_l_option(@file_list.file_names) : show_other_than_l_option(@file_list.file_names)
  end

  private

  def show_l_option(files)
    file_infos = files.map { |file| FileInfo.new(file) }
    total_block_size = file_infos.sum(&:block_size)
    puts "total #{total_block_size}"

    max_filesize_length = make_length_of_max_size_file(file_infos)
    file_infos.each do |file_info|
      puts format_file_info(file_info, max_filesize_length)
    end
  end

  def make_length_of_max_size_file(file_infos)
    file_infos.map { |file_info| file_info.stat.size.to_s.length }.max
  end

  def format_file_info(file_info, max_filesize_length)
    filetype_and_permissions = "#{file_info.filetype_short}#{file_info.permissions}"
    hardlink = file_info.hardlink
    owner_and_group = "#{file_info.owner_name}  #{file_info.group_name}"
    format_filesize = file_info.filesize.rjust(max_filesize_length)
    time_stamp = file_info.time_stamp
    name_and_symbolic_link = "#{file_info.file_name}#{symbolic_link_info(file_info.file_name)}"

    "#{filetype_and_permissions} #{hardlink} #{owner_and_group}  #{format_filesize} #{time_stamp} #{name_and_symbolic_link}"
  end

  def symbolic_link_info(file_name)
    return " -> #{File.realpath(file_name)}" if File.symlink?(file_name)
  end

  def show_other_than_l_option(files)
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
end
