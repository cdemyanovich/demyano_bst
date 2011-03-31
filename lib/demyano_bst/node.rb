module DemyanoBst
  
  class Node
    
    attr_accessor :value, :parent, :left_child, :right_child

    def initialize(value, parent = nil)
      @value = value
      @parent = parent
    end

    def disown(child)
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

    # right-most child of left child
    def in_order_predecessor
      return nil if leaf?
      node = self.left_child
      while node.right_child
        node = node.right_child
      end
      node
    end
    
    def replace_in_parent(new_child)
      if self.parent
        if self.parent.left_child == self
          self.parent.left_child = new_child
        else
          self.parent.right_child = new_child
        end
      end
      new_child.parent = self.parent
    end

    # check the left child, since we're using in-order predecessor when
    # handling a delete of a node with 2 children
    def adopt_children_of(other_parent)
      if other_parent.left_child != self
        self.left_child = other_parent.left_child
        self.left_child.parent = self
      end
      self.right_child = other_parent.right_child
      self.right_child.parent = self
    end

  end

end
