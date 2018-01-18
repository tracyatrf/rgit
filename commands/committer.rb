class Committer
  def run
    puts TreeBuilder.create_trees(Index.load.files)
  end
end
