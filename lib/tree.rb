require "pry-byebug"

class Tree
  def initialize(ary)
    @ary = clean_ary(ary)
    @root = build_tree(@ary)
  end

  def insert(value)
    # add check for value in tree before inserting it
    # (return if find value)?
    node = Node.new(value)
    insert_recursive(node, @root)
  end

  def delete(value)
    delete_recursive(value, @root)
  end

  def extract_node(node)
    puts "Extracting node -> #{node.data}"
    node.data
  end

  # implement recursive approach too
  def find(value, root = @root)
    loop do
      return root if root.data == value
      if value < root.data
        root = root.left
      elsif value > root.data
        root = root.right
      end
    end
  end

  def clean_ary(ary)
    ary.sort!
    set = Set.new(ary)
    set.to_a
  end

  # OPTIMIZE: Make more readable and understand regular implementation
  def min_value(root = @root)
    root = root.left until root.left.nil?
    root.data
  end

  def build_tree(ary = @ary, ary_start = 0, ary_end = (ary.length - 1))
    return nil if ary_start > ary_end

    middle = (ary_start + ary_end) / 2

    root = Node.new(ary[middle])

    root.left = build_tree(ary, ary_start, (middle - 1))
    root.right = build_tree(ary, (middle + 1), ary_end)

    root
  end

  # pretty print method - courtesy of TOP
  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  # OPTIMIZE: remove insert method
  def insert_recursive(node, root)
    root = node if root.nil?

    if node < root
      root.left = insert_recursive(node, root.left)
    elsif node > root
      root.right = insert_recursive(node, root.right)
    end
    root
  end

  def delete_recursive(value, root)
    return root if root.nil?

    if value < root.data
      root.left = delete_recursive(value, root.left)
    elsif value > root.data
      root.right = delete_recursive(value, root.right)
    else
      # binding.pry
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      # get the inorder successor
      root.data = min_value(root.right)
      root.right = delete_recursive(root.data, root.right)
    end
    root
  end
end
