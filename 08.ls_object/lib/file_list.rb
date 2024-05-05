# frozen_string_literal: true

class FileList
  attr_reader :file_names

  def initialize(options)
    files = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
    @file_names = options['r'] ? files.reverse : files
  end
end
