module ArtifactPersistable
  #requires included class to implement type and content
  attr_accessor :sha

  def self.included(base)
    base.extend(ClassMethods)
  end

  def type
    self.class.name.underscore
  end

  def persist
    self.sha = Artifact.create(type: type, raw_content: raw_content).sha
    self
  end

  module ClassMethods
    def load(sha)
      new(**extract_data(read_artifact(sha)[:raw_content]), sha: sha)
    end

    def extract_data(artifact)
      raise "Subclass must implement"
    end

    def read_artifact(sha)
      raise "No sha provided or artifact does not exist" unless sha && Artifact.exists?(sha)
      Artifact.read(sha)
    end
  end
end
