class Committer
  def run(message, *_args)
    commit_content = {
      tree: TreeBuilder.create_trees(Index.load.files)[:sha],
      message: message
    }
    artifact = Artifact.create(type: :commit, raw_content: commit_content.to_yaml)
    puts "Successfully created commit #{artifact.sha}"
    true
  end
end
