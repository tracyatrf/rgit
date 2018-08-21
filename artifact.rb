class Artifact
  class InvalidArtifact < StandardError; end

  class << self
    def file_path(sha)
      "#{RGIT_DIR}/objects/%s" % sha
    end

    def read(sha)
      File.read(file_path(sha))
        .partition(?:)
        .tap{ |a| break { type: a.first, raw_content: a.last } }
    end

    def create(type:, raw_content:)
      new(raw_content: raw_content, type: type).save
    end

    def exists?(sha)
      begin
        File.read(file_path(sha)) && true
      rescue
        false
      end
    end
  end

  attr_reader :sha, :type

  def initialize(type:, raw_content:)
    @raw_content = raw_content
    @type = type
    generate_sha
  end

  def save
    File.open(file_path, "w") { |file| file.write(write_content) }
    self
  end

  def write_content
    "#{type}:#{raw_content}"
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
    @sha ||= Util::Hasher.generate_sha(raw_content)
  end

  def file_path
    self.class.file_path(sha)
  end
end
