class Committer
  def run(message, *_args)
    sha = create_artifact(commit_content(message)).sha
    print_success_message(sha)
  end

  def commit_content(message)
    {
      tree: create_trees[:sha],
      message: message
    }
  end

  def create_trees
    TreeBuilder.create_trees(Index.load.files)
  end

  def print_success_message(sha)
    puts "Successfully created commit #{artifact.sha}"
  end

  def create_artifact(commit_content)
    Artifact.create(type: :commit, raw_content: commit_content.to_yaml)
  end
end
