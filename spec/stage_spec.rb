RSpec.describe Stage do
  let(:subject) { Stage.new }

  it "in can be instantgated" do
    expect(subject).to be_a Stage
  end

  it "has a working tree" do 
    expect(subject.working_tree).to be_a WorkingTree
  end

  it "has an index" do 
    expect(subject.index).to be_a Index
  end

  context "with some differences" do
    let(:index) do
      Index.new([
        { sha: "1234", name: "file_one" },
        { sha: "5678", name: "file_two" },
        { sha: "4321", name: "file_three" }])
    end

    let(:working_tree) { WorkingTree.new(["file_one", "file_two", "file_three"]) }
    let(:subject) { Stage.new(working_tree: working_tree, index: index) }
    before(:each) do
      allow(working_tree).to receive(:files)
        .and_return(["file_one", "file_two", "file_three"])
      allow(working_tree).to receive(:hash_tree)
        .and_return([
          { sha: "1234", name: "file_one" },
          { sha: "2345", name: "file_two" },
          { sha: "5432", name: "file_four" }])
    end

    it "detects a new file" do
      expect(subject.new_files).to eq ["file_four"]
    end

    it "detects a changed file" do
      expect(subject.changed_files).to eq ["file_two"]
    end

    it "detects a deleted file" do
      expect(subject.deleted_files).to eq ["file_three"]
    end
  end
end
