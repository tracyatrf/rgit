class Status
  def stage
    @stage ||= Stage.new
  end

  def run
    puts "these files have changed:"
    puts stage.difference_vs_working_tree.join("\n")
  end
end
