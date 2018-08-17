class Head
  class InvalidHeadError < StandardError; end
  class << self
    def sha
      new.sha
    end

    def branch
      new.branch
    end
  end

  attr_reader :branch

  def initialize(branch=nil)
    @branch = branch || Branch.find(read_head_file)
  end

  def read_head_file(filename="#{RGIT_DIR}/HEAD")
    File.file?(filename) ? File.read(filename).chomp : raise("You are in a detatched head state")
  end

  def sha
    branch.commit
  end
end
