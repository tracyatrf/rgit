class Branch
  class << self
    def find(name)
      commit = File.read("#{RGIT_DIR}/refs/branches/#{name}")
      new(name: name, commit: commit)
    end
  end

  def initialize()

  end
end
