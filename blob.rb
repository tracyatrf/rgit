class Blob
  include ArtifactPersistable
  attr_reader :content

  def initialize(content:)
  end
end

