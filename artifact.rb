require 'zlib'
require 'digest'

class Artifact
  class InvalidArtifact < StandardError; end

  class << self
    def retrieve(sha)
      new(compressed_content: File.read(".rgit/objects/%s", sha))
    end
  end

  attr_reader :compressed_content, :content, :sha

  def initialize(compressed_content: nil, content: nil)
    validate(compressed_content, content)
    @compressed_content = compressed_content
    @content = content
    generate_missing
  end

  private

  def generate_missing
    generate_compressed_content
    generate_content
    generate_sha
  end

  def generate_compressed_content
    @compressed_content ||= Zlib::Deflate.deflate(content)
  end

  def generate_content
    @content ||= Zlib::Inflate.inflate(compressed_content)
  end

  def generate_sha
    @sha ||= Digest::SHA1.hexdigest(compressed_content)
  end

  def validate(compressed_content, content)
    raise InvalidArtifact "No file contents available" unless (compressed_content || content)
    raise InvalidArtifact "Cannot initialize with both compressed and uncompressed contents" if (compressed_content && content)
  end
end
