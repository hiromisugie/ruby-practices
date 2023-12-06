# frozen_string_literal: true

require 'etc'
require 'date'

class FileInfo
  attr_reader :file_name, :stat

  def initialize(file_name)
    @file_name = file_name
    @stat = File.lstat(file_name)
  end

  def block_size
    @stat.blocks
  end

  def filetype_short
    make_filetype(@stat.ftype)
  end

  def permissions
    format_permissions(@stat.mode)
  end

  def hardlink
    @stat.nlink.to_s.rjust(2)
  end

  def owner_name
    Etc.getpwuid(@stat.uid).name
  end

  def group_name
    Etc.getgrgid(@stat.gid).name
  end

  def filesize
    @stat.size.to_s
  end

  def time_stamp
    make_time_stamp(@stat)
  end

  def symbolic_link_info
    symbolic_link
  end

  private

  def make_filetype(filetype)
    filetypes = {
      'file' => '-',
      'directory' => 'd',
      'link' => 'l'
    }
    filetypes[filetype]
  end

  def format_permissions(statmode)
    filemode = statmode.to_s(8).rjust(6, '0')
    filemode_owner = make_filemode(filemode[3].to_i)
    filemode_owned_group = make_filemode(filemode[4].to_i)
    filemode_other_users = make_filemode(filemode[5].to_i)
    "#{filemode_owner}#{filemode_owned_group}#{filemode_other_users}"
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

  def make_time_stamp(stat)
    month = stat.mtime.strftime('%m').to_i.to_s.rjust(2)
    day = stat.mtime.strftime('%e')
    time = stat.mtime.strftime('%H:%M')
    "#{month} #{day} #{time}"
  end

  def symbolic_link
    return " -> #{File.realpath(@file_name)}" if File.symlink?(@file_name)
  end
end
