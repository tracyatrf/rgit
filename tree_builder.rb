module TreeBuilder
  class << self

    def create_trees(files)
      { name: "root", sha: reduce_tree(files) }
    end

    def load_tree(sha)
      recursive_build_tree(Tree.load(sha))
    end

    def recursive_build_tree(tree)
      Tree.new(
        sha: tree.sha,
        files: tree.files,
        trees: tree.trees.map do |t|
          { name: t[:name], tree: recursive_build_tree(Tree.load(t[:sha])) }
        end
      )
    end

    def recursive_load_files(tree)
      recursive_flatten_files(recursive_build_tree(tree))
    end

    def recursive_flatten_files(tree_branch, path='')
      [
        tree_branch.files.map{ |f| { sha: f[:sha], name: (path + f[:name]) } },
        tree_branch.trees.map{ |t| recursive_flatten_files(t[:tree], path+t[:name]+?/) }
      ].flatten
    end

    private

    def reduce_tree(files)
      grouped = group_by_filename(files)
      subtree = grouped.each_with_object({trees:[], files:[]}) do |(key, values), memo|
        if key == "." then memo[:files] += values
        else
          reduced_files = values.each { |file| file[:name] = file[:name].rpartition("/").last }
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

