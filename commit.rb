class Commit
  include ArtifactPesistable

  class << self
    def create(root_tree: root_tree)
      sha = new(root_tree: root_tree).persist.sha
      load(sha)
    end

    def load(sha)

    end
  end

  def initialize(root_tree:, sha: nil)
    @root_tree = root_tree
  end

  def content
    { tree: root_tree, type: :commit }.to_yaml
  end

  def root_tree
    @root_tree
  end

  def sha

  end
end
