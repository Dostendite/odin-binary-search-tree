require "pry-byebug"

class Tree
  def initialize(ary)
    @ary = clean_ary(ary)
    @root = build_tree(@ary)
  end

  def clean_ary(ary)  
    ary.sort!
    set = Set.new(ary)
    set.to_a
  end

  def build_tree(ary=@ary, ary_start=0, ary_end=(ary.length-1))
    return if ary_start > ary_end

    middle = (ary_start + ary_end) / 2

    root = Node.new(ary[middle])

    root.left_child = build_tree(ary, ary_start, (middle - 1))
    root.right_child = build_tree(ary, (middle + 1), ary_end)

    root
  end
    
  # pretty print method - courtesy of TOP
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
   