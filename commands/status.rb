class Status
  def stage
    @stage ||= Stage.new
  end

  def run
    puts "these files have changed:"
    puts stage.changed_files.join("\n")

    puts "these files have are new:"
    puts stage.new_files.join("\n")

    puts "these files have are deleted:"
    puts stage.deleted_files.join("\n")
  end
end
