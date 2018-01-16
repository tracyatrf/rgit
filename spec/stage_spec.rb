RSpec.describe Stage do
  let(:subject) { Stage.new }

  it "in can be instanciated" do
    expect(subject).to be_a Stage
  end

  it "has a working tree" do 
    expect(subject.working_tree).to be_a WorkingTree
  end

end
