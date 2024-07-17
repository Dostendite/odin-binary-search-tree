require "pry-byebug"

class Tree
  def initialize(ary)
    @ary = clean_ary(ary)
    @root = build_tree(@ary)
  end

  def insert(value)
    @ary << value
    clean_ary(@ary)
    node = Node.new(value)
    insert_recursive(node, @root)
  end

  def delete(value)
    @ary.delete(value)
    clean_ary(@ary)
    delete_recursive(value, @root)
  end

  def extract_node(node)
    puts "Extracting node -> #{node.data}"
    node.data
  end

  def find(value, root = @root)
    return root if root.nil? || root.data == value

    if value < root.data
      find(value, root.left)
    elsif value > root.data
      find(value, root.right)
    end
  end

  def height(value)
    target_node = find(value)
    return nil if target_node.nil?

    height_recursive(target_node)
  end

  def depth(value)
    root = @root
    found = false
    edges = 0

    until found
      if value == root.data
        return edges
      elsif value > root.data
        edges += 1
        root = root.right
      elsif value < root.data
        edges += 1
        root = root.left
      end
    end
  end

  # OPTIMIZE: depth first traversal methods
  def inorder(root = @root, ret_ary = [])
    return if root.nil?

    inorder(root.left, ret_ary)
    yield root if block_given?
    ret_ary << root
    inorder(root.right, ret_ary)

    return ret_ary if ret_ary.length == @ary.length

    root
  end

  def preorder(root = @root, ret_ary = [])
    return root if root.nil?

    yield root if block_given?
    ret_ary << root
    preorder(root.left, ret_ary)
    preorder(root.right, ret_ary)

    return ret_ary if ret_ary.length == @ary.length

    root
  end

  def postorder(root = @root, ret_ary = [])
    return root if root.nil?

    postorder(root.left, ret_ary)
    postorder(root.right, ret_ary)
    yield root if block_given?
    ret_ary << root

    return ret_ary if ret_ary.length == @ary.length

    root
  end

  def level_order
    return if @root.nil?

    visited_nodes = []
    queue = []
    queue.unshift(@root)
    until queue.empty?
      current_node = queue[-1]
      yield current_node if block_given?

      queue.unshift(current_node.left) unless current_node.left.nil?
      queue.unshift(current_node.right) unless current_node.right.nil?

      visited_nodes << queue.pop
    end
    visited_nodes
  end

  def clean_ary(ary)
    ary.sort!
    set = Set.new(ary)
    set.to_a
  end

  # OPTIMIZE: make more readable and understand regular implementation
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

  def height_recursive(node, edges = 0)
    return nil if node.nil?
    return edges if node.left.nil? && node.right.nil?

    node_left = height_recursive(node.left, edges + 1)
    node_right = height_recursive(node.right, edges + 1)

    return node_right if node_left.nil?
    return node_left if node_right.nil?

    [node_left, node_right].max
  end

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
