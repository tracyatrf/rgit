class Head
  class InvalidHeadError < StandardError; end
  class << self
    def sha
      new.sha
    end
  end

  attr_reader :branch

  def initialize(branch=nil)
    @branch = branch || Branch.find(read_head_file)
  end

  def read_head_file
    File.read("#{RGIT_DIR}/HEAD")
  end

  def sha
    branch.current_commit
  end
end
