class Commit
  include ArtifactPersistable
  attr_reader :tree, :parent, :message

  class << self
    def create(tree:, parent: nil, message:)
      new(tree: tree, parent: parent, message: message).persist
    end

    def extract_data(file_contents)
      YAML.load(file_contents)
    end
  end

  def initialize(tree:, sha: nil, parent: nil, message:)
    @tree = tree
    @parent = parent
    @message = message
    @sha = sha
  end

  def to_h
    { tree: tree, parent: parent, message: message, sha: sha }
  end

  def raw_content
    to_h.except(:sha).to_yaml
  end
end
