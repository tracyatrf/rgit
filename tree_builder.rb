class TreeBuilder
  class << self

    def recursive_build_tree_from_sha(sha)
      recursive_build_tree(Tree.load(sha))
    end

    def recursive_build_tree(tree)
      Tree.new(sha: sha, trees: tree.trees.map{ |t| recursive_build_tree(t[:sha]) }, files: tree.files )
    end

    def create_trees(files)
      { name: "root", sha: reduce_tree(files) }
    end

    private

    def reduce_tree(files)
      grouped = group_by_filename(files) 
      subtree = grouped.each_with_object({trees:[], files:[]}) do |(key, values), memo|
        if key == "." then memo[:files] += values
        else
          reduced_files = values.each { |file| file[:name] = file[:name].rpartition("/").first }
          memo[:trees] << { name: key, sha: reduce_tree(reduced_files) }
        end
      end
      Artifact.create(type: :tree, raw_content: subtree.to_yaml).sha
    end

    def group_by_filename(files)
      files.group_by{|f| File.dirname(f[:name]).split("/").first}
    end

  end
end

