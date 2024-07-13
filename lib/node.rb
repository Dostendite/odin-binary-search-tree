class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def to_s
    ret_string = "(#{data})"
    ret_string.prepend("(#{left}) <- ") unless @left.nil?
    ret_string << " -> (#{right})" unless @right.nil?

    ret_string
  end

  def <=>(other)
    @data <=> other.data
  end
end
