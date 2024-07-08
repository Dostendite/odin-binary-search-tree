require "pry-byebug"

class Tree
  def initialize(ary)
    @ary = clean_ary(ary)
    @root = build_tree(@ary)
  end

  def insert(value)
    node = Node.new(value)
    insert_recursive(@root, node)
  end

  def clean_ary(ary)
    ary.sort!
    set = Set.new(ary)
    set.to_a
  end

  def build_tree(ary = @ary, ary_start = 0, ary_end = (ary.length - 1))
    return nil if ary_start > ary_end

    middle = (ary_start + ary_end) / 2

    root = Node.new(ary[middle])

    root.left_child = build_tree(ary, ary_start, (middle - 1))
    root.right_child = build_tree(ary, (middle + 1), ary_end)

    root
  end

  # pretty print method - courtesy of TOP
  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  # OPTIMIZE: -> fix comparable spaceship nil bug
  # remove insert method
  def insert_recursive(root, node)
    root = node if root == nil

    if node < root
      root.left_child = insert_recursive(root.left_child, node)
    elsif node > root
      root.right_child = insert_recursive(root.right_child, node)
    end

    root
  end

  def delete(value)
    # 3 cases:
    # leaf -> that's it
    # one child -> replace it with its child
    # two children -> find the node that is next biggest (just bigger than it)
    # explore its right subtree and get the leaf farthest to the left
    # and replace it with that node (find it all the way to the left)
  end
end
