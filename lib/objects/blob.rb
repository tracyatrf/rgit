class Blob
  include ArtifactPersistable
  attr_reader :raw_content

  class << self
    def create(raw_content:)
      new(raw_content: raw_content).persist
    end

    def extract_data(file_contents)
      { raw_content: file_contents }
    end
  end

  def initialize(raw_content:, sha: nil)
    @raw_content = raw_content
    @sha = sha
  end
end

