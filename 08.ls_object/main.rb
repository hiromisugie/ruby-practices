# frozen_string_literal: true

require 'optparse'
require_relative 'lib/file_list'
require_relative 'lib/file_info'
require_relative 'lib/file_display'

NUMBER_OF_COLUMN = 3
NUMBER_OF_SPACE = 4

options = ARGV.getopts('lar')

file_list = FileList.new(options)
file_display = FileDisplay.new(file_list, options)

file_display.display
