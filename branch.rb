class Branch
  class << self
    def find(name)
      commit = File.read("#{RGIT_DIR}/refs/#{name}").tap { |f| break nil if f.empty? }
      new(name: name, commit: commit)
    end

    def create(name:, commit:)
      new(name: name, commit: commit).save
    end

    def file_path(name)
      "#{RGIT_DIR}/refs/%s" % name
    end

    def save(name:, commit:)
      new(name: name, commit: commit).save
    end
  end

  attr_reader :name, :commit

  def initialize(name:, commit:)
    @name = name
    @commit = commit
  end

  def update_commit(sha)
    self.class.save(name: name, commit: sha)
  end

  def file_path
    self.class.file_path(name)
  end

  def save
    File.open(file_path, "w") { |file| file.write(commit) }
  end
end
