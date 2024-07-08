class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def to_s
    "(#{@left_child}) <- (#{@data}) -> (#{@right_child})"
  end

  def <=>(other)
    @data <=> other.data
  end
end
