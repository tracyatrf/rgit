class Stage
  attr_reader :working_tree, :index

  def initialize(working_tree: WorkingTree.new, index: Index.load)
    @working_tree = working_tree
    @index = index
  end

  def working_tree_files
    working_tree.hash_tree
  end

  def index_files
    index.files
  end

  def new_shas
    working_tree_files - index_files
  end

  def new_files
    # a file is new if the file is not in the index. We do not distinguish if it is renamed/moved at the this time.
    working_tree_files.map{|f| f[:name]} - index.files.map{|f| f[:name]}
  end

  def changed_files
    # we need to find files in the working tree that are listed in the index, 
    # matching on name, but with different shas.
    working_tree_files.select { |file| find_matching_index_file(file) }.map{ |file| file[:name] }
  end

  def deleted_files
    index_files.map{|f| f[:name]} - working_tree_files.map{|f| f[:name]}
  end

  def staged_files
    #diffence vs repo
    (index_files - repo_files).map{|f| f[:name]}
  end

  private

  def find_matching_index_file(file)
    index_files.find do |idx_file|
      idx_file[:name] == file[:name] && idx_file[:sha] != file[:sha]
    end
  end

  def repo_files(commit=Commit.load(Head.sha))
    TreeBuilder.recursive_load_files(Tree.load(commit.tree))
  end
end
