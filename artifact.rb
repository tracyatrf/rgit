class Artifact
  class InvalidArtifact < StandardError; end

  class << self
    def file_path(sha)
      "#{RGIT_DIR}/objects/%s" % sha
    end

    def create(type:, raw_content:)
      new(raw_content: raw_content, type: type).save
    end

  end

  attr_reader :sha

  def initialize(type:, raw_content:)
    @raw_content = raw_content
    @type = type
    generate_sha
  end

  def save
    File.open(file_path, "w") do |file|
      file.write(raw_content)
    end
    self
  end

  def delete
    #noop
  end

  private

  attr_reader :raw_content

  def new
    super
  end

  def generate_sha
    @sha ||= Digest::SHA1.hexdigest(raw_content)
  end

  def file_path
    self.class.file_path(sha)
  end
end
