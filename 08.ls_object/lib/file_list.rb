# frozen_string_literal: true

class FileList
  attr_reader :file_names

  def initialize(options)
    @file_names = file_list(options)
  end

  private

  def file_list(options)
    files = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
    options['r'] ? files.reverse : files
  end
end
