module ArtifactPersistable
  #requires included class to implement type and content
  #
  def type
    self.class.underscore
  end
  
  def persist
    Artifact.create(type: type, raw_content: content)
  end
end
