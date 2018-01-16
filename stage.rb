class Stage
  def working_tree
    @working_tree = WorkingTree.new
  end

  def index
    @index ||= Index.load
  end

  def working_tree_files
    working_tree.hash_tree
  end

  def difference_vs_working_tree
    working_tree_files - index.files
  end

  def difference_vs_repo
    #no op currently
  end
end
