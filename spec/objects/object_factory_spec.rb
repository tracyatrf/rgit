RSpec.describe ObjectFactory do
  before(:each) do
    clear_objects
  end

  it "Returns the correct type of object" do
    persisted = Blob.create(raw_content: "test content")
    loaded = ObjectFactory.load(persisted.sha)
    expect(loaded).to be_a Blob
  end

  it "parses the values properly to the right class" do
    persisted = Commit.create(tree: "aaa", parent: "bbb", message: "test commit message")
    loaded = ObjectFactory.load(persisted.sha)
    expect(loaded).to be_a Commit
    expect(loaded.parent).to eq "bbb"
    expect(loaded.tree).to eq "aaa"
    expect(loaded.message).to eq "test commit message"
  end
end
