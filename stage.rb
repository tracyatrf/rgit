class Stage
  def working_tree
    @working_tree = WorkingTree.new
  end

  def working_tree_files
    working_tree.files
  end

  def create_artifact_from_file(file)
    Artifact.new(
      artifact_type: :file,
      raw_content: file
    )
  end

  def create_artifacts_from_working_tree
    working_tree_files.map do |file|
      create_artifact_from_file(file)
    end
  end

  def read_index
    JSON.parse(File.read(".rgit/index"))
  end
end


