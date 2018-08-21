class History
  attr_reader :root_commit

  def initialize(commit)
    @root_commit = commit
  end

  def full_log
    log(full_history) do |commit|
      ap commit.to_h
    end
  end

  def log(history)
    history.each do |commit|
      yield commit
    end
  end

  def full_history
    [root_commit, ancestor_chain(root_commit.load_parent)].flatten
  end

  def ancestor_chain(commit)
    # we return [] instead of nil because it flattens out
    return [] unless commit
    [commit, ancestor_chain(commit.load_parent)]
  end
end
