module ArtifactPersistable
  #requires included class to implement type and content
  #
  def self.included(base)
    base.extend(ClassMethods)
  end

  def type
    self.class.underscore
  end

  def persist
    Artifact.create(type: type, raw_content: content)
  end

  module ClassMethods
    def read_artifact(sha)
      raise "No sha provided or artifact does not exist" unless sha && Artifact.exists?(sha)
      Artifact.read(sha)
    end
  end
end
