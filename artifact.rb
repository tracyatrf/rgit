class Artifact
  class InvalidArtifact < StandardError; end

  class << self
    def retrieve(sha:, artifact_type:)
      new(
        artifact_type: artifact_type,
        compressed_content: File.read(file_path(sha))
      )
    end

    def file_path(sha)
      ".rgit/objects/%s" % sha
    end
  end

  attr_reader :artifact_type, :compressed_content, :content_hash, :raw_content, :sha

  def initialize(artifact_type:, compressed_content: nil, raw_content: nil)
    validate(compressed_content, raw_content)
    @artifact_type = artifact_type
    @compressed_content = compressed_content
    @raw_content = raw_content
    generate_missing
  end

  def save
    File.open(file_path, "w") do |file|
      file.write(compressed_content)
    end
  end

  private

  def generate_missing
    generate_content_hash
    generate_raw_content
    generate_compressed_content
    generate_sha
  end

  def generate_compressed_content
    @compressed_content ||= Zlib::Deflate.deflate(content_hash.to_json)
  end

  def generate_raw_content
    @raw_content ||= content_hash["file_contents"]
  end

  def generate_content_hash
    @content_hash = JSON.parse(Zlib::Inflate.inflate(compressed_content)) if compressed_content
    @content_hash = {
      artifact_type: artifact_type,
      file_contents: raw_content
    } if raw_content
  end

  def generate_sha
    @sha ||= Digest::SHA1.hexdigest(compressed_content)
  end

  def validate(compressed_content, raw_content)
    raise InvalidArtifact "No file contents available" unless (compressed_content || raw_content)
    raise InvalidArtifact "Cannot initialize with this data" if (compressed_content && raw_content)
  end

  def file_path
    self.class.file_path(sha)
  end
end
