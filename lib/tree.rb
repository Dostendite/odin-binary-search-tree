class Tree
  def initialize(ary)
    @ary = clean_array(ary)
    @root = nil # = build_tree(ary)
  end

  def clean_array(ary)  
    ary.sort!
    set = Set.new(ary)
    set.to_a
  end
end
   