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
    insert_recursive(@root, node)
  end

  def delete(value)
    delete_recursive(@root, value)
  end

  # def find(root = @root, value)
  #   return root if root.nil?
  #   return root if root.data == value

  #   root.left = find(root.left, value)
  #   root.right = find(root.right, value)

  #   root
  # end

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
  def insert_recursive(root, node)
    root = node if root.nil?

    if node < root
      root.left = insert_recursive(root.left, node)
    elsif node > root
      root.right = insert_recursive(root.right, node)
    end
    root
  end

  def delete_recursive(root, value)
    return root if root.nil?

    if value < root.data
      root.left = delete_recursive(root.left, value)
    elsif value > root.data
      root.right = delete_recursive(root.right, value)
    else
      # binding.pry
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      # get the inorder successor
      root.data = min_value(root.right)
      root.right = delete_recursive(root.right, root.data)
    end
    root
  end
end
