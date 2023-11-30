# frozen_string_literal: true

class FileList
  attr_reader :file_names

  def initialize(options)
    @options = options
    @file_names = file_list
  end

  private

  def file_list
    file_list = @options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
    @options['r'] ? file_list.reverse : file_list
  end
end
