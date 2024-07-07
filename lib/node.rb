class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child
  
  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def to_s
    "( #{@left_child} ) <- ( #{@data} ) -> ( #{@right_child})"
  end

  def <=>(other)
    @data <=> other.data
  end

  def set_left_child(data)
    @left_child = data
  end

  def set_right_child(data)
    @right_child = data
  end
end