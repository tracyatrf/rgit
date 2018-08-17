class Committer
  def run(message, *_args)
    current_commit = Head.sha
    sha = create_artifact(commit_content(message)).sha
    print_success_message(sha)
    update_refs(sha)
  end

  def update_refs(sha)
    Head.new.branch.update_commit(sha)
  end

  def commit_content(message)
    {
      tree: create_trees[:sha],
      parent: Head.sha,
      message: message
    }
  end

  def create_trees
    TreeBuilder.create_trees(Index.load.files)
  end

  def print_success_message(sha)
    puts "Successfully created commit #{sha}"
  end

  def create_artifact(commit_content)
    Artifact.create(type: :commit, raw_content: commit_content.to_yaml)
  end
end
