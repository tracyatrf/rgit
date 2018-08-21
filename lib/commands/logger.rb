class Logger
  def run(sha=Head.sha)
    History.new(Commit.load(sha)).full_log
  end
end
