RSpec.describe do
  let(:first_commit) {
    Commit.create(tree: "aaa", message: "test commit message")
  }

  let(:second_commit) {
    Commit.create(tree: "aab", parent: first_commit.sha, message: "test commit message 2")
  }

  let(:current_commit) {
    Commit.create(tree: "aac", parent: second_commit.sha, message: "test commit message 3")
  }

  it "Provides an array of previous commits" do
    history = History.new(current_commit)
    expect(history.full_history.length).to eq 3
    expect(history.full_history.all?{ |x| x.is_a? Commit }).to be_truthy
  end
end
