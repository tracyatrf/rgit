class Index
  INDEX_FILE_PATH = "#{RGIT_DIR}/index.yml"

  class << self
    def load
      files = YAML.load_file(INDEX_FILE_PATH)
      new(files)
    end
  end

  attr_reader :files

  def initialize(files = [])
    @files = files
  end

  def add_file(file_hash)
    # we need to delete the old reference first
    @files = files.reject { |file| file[:name] == file_hash[:name] }
    files << file_hash
  end

  def write
    File.write(INDEX_FILE_PATH, files.to_yaml)
  end
end

