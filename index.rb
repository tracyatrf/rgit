class Stage
  def initialize
    @working_tree = WorkingTree.new
  end

  def create_artifact_from_file(file)
    Artifact.new(
      artifact_type: file,
      raw_content: file
    )
  end
end
