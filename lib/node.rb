class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def to_s
    "(#{@left}) <- (#{@data}) -> (#{@right})"
  end

  # this might be a bad practice, do some research
  def <=>(other)
    @data <=> other.data
  end
end
