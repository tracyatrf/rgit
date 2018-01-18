class TreeBuilder
  class << self

    def create_trees(files)
      { name: "root", sha: reduce_tree(files) }
    end

    private

    def reduce_tree(files)
      #group by filename
      grouped = group_by_filename(files) 

      #fold paths #
      obj = grouped.each_with_object({trees:[], files:[]}) do |(key, values), memo|
        if key == "."
          memo[:files] += values
        else
          reduced_files = values.map do |file|
            file[:name] = file[:name].split("/")[1..-1].join("/")
            file
          end
          subtree = reduce_tree(reduced_files)
          memo[:trees] << { name: key, sha: subtree }
        end
      end
      Artifact.create(type: :tree, raw_content: obj.to_yaml).sha
    end

    def group_by_filename(files)
      files.group_by{|f| File.dirname(f[:name]).split("/").first}
    end
  end
end

