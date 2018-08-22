class Status
  def stage
    @stage ||= Stage.new
  end

  def run
    puts "On branch #{Head.branch.name}"
    puts "these files are ready for commit:"
    puts stage.staged_files.join("\n")

    puts "these files have changed:"
    puts stage.changed_files.join("\n")

    puts "these files have are new:"
    puts stage.new_files.join("\n")

    puts "these files have been deleted:"
    puts stage.deleted_files.join("\n")
  end
end
