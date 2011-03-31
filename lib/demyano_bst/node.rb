module DemyanoBst
  
  class Node
    
    attr_accessor :value, :parent, :left_child, :right_child

    def initialize(value, parent = nil)
      @value = value
      @parent = parent
    end

    def delete(child)
      self.left_child  = nil if self.left_child  && self.left_child.value  == child.value
      self.right_child = nil if self.right_child && self.right_child.value == child.value
    end

    def root?
      self.parent.nil?
    end

    def leaf?
      self.left_child.nil? && self.right_child.nil?
    end

    def only_child
      return nil if leaf?
      return nil if self.left_child && self.right_child
      return self.left_child if self.left_child
      return self.right_child if self.right_child
    end

    # right-most node of left sub-tree
    def predecessor
      return nil if leaf?
      node = self.left_child
      while node.right_child
        node = node.right_child
      end
      node
    end

  end

end
