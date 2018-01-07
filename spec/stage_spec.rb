RSpec.describe Stage do
  let(:subject) { Stage.new }

  it "in can be instanciated" do
    expect(subject).to be_a Stage
  end

  it "has a working tree" do 
    expect(subject.working_tree).to be_a WorkingTree
  end

  it "creates artifacts from files" do 
    allow(subject).to receive(:working_tree_files)
      .and_return(JSON.parse(File.read('spec/fixtures/working_tree_files.json')))
    artifacts = subject.create_artifacts_from_working_tree
    expect(artifacts).to all(be_an Artifact)
    expect(artifacts.map(&:artifact_type)).to all(eq :file)
  end
end
