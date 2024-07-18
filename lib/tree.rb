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

  def rebalance
    new_array = rebalance_recursive(@root)
    @root = build_tree(clean_ary(new_array))
  end

  def balanced?
    left_subtree_depth = balanced_recursive(@root.left)
    right_subtree_depth = balanced_recursive(@root.right)

    (left_subtree_depth - right_subtree_depth).abs <= 1
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

  # add edge case handling
  def depth(value)
    root = @root
    edges = 0

    loop do
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
  def inorder(root = @root, return_ary = [], &block)
    return if root.nil?

    inorder(root.left, return_ary, &block)
    yield(root) if block_given?
    return_ary << root
    inorder(root.right, return_ary, &block)

    if return_ary.length == @ary.length
      return_ary
    else
      root
    end
  end

  def preorder(root = @root, return_ary = [], &block)
    return root if root.nil?

    yield root if block_given?
    return_ary << root
    preorder(root.left, return_ary, &block)
    preorder(root.right, return_ary, &block)

    if return_ary.length == @ary.length
      return_ary
    else
      root
    end
  end

  def postorder(root = @root, return_ary = [], &block)
    return root if root.nil?

    postorder(root.left, return_ary, &block)
    postorder(root.right, return_ary, &block)
    yield root if block_given?
    return_ary << root

    if return_ary.length == @ary.length
      return_ary
    else
      root
    end
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

  def rebalance_recursive(root = @root, return_ary = [])
    return nil if root.nil?

    rebalance_recursive(root.left, return_ary)
    rebalance_recursive(root.right, return_ary)
    return_ary << root.data unless root.nil?
  end

  def balanced_recursive(root)
    return depth(root.data) if root.left.nil? && root.right.nil?

    unless root.left.nil?
      left_depth = balanced_recursive(root.left)
    end

    unless root.right.nil?
      right_depth = balanced_recursive(root.right)
    end

    if left_depth.nil?
      right_depth
    elsif right_depth.nil?
      left_depth
    else
      [left_depth, right_depth].max
    end
  end

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
