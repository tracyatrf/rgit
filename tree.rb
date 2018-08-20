class Tree
  include ArtifactPersistable
  attr_reader :trees, :files

  class << self
    def create(trees:, files:)
      new(trees: trees, files: files).persist
    end

    def extract_data(file_contents)
      YAML.load(file_contents)
    end
  end

  def initialize(trees:, sha: nil, files:)
    @trees = trees
    @files = files
  end

  def to_h
    { sha: sha, trees: trees.map(&:sha), files: files.map(&:sha) }
  end

  def raw_content
    to_h.except(:sha).to_yaml
  end
end
