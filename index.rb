class Index
  class << self
    def load
      files = YAML.load("#{RGIT_DIR}/index.yml")
      new(files)
    end
  end

  def initialize(files)
    @files = files
  end

  def add_file(file)

  end
end

