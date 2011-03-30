module DemyanoBst
  
  class BinarySearchTree
    
    attr_reader :root
    
    def initialize(root = nil)
      @root = root
    end
    
    def search(value, node = root)
      return nil if node.nil?
      if value < node.value
        return search(value, node.left_child)
      elsif value > node.value
        return search(value, node.right_child)
      else
        return node
      end
    end
    
    def insert(value, node = root)
      if root.nil?
        @root = Node.new(value)
        return @root
      elsif value < node.value
        if node.left_child.nil?
          node.left_child = Node.new(value)
          return node.left_child
        else
          return insert(value, node.left_child)
        end
      elsif value > node.value
        if node.right_child.nil?
          node.right_child = Node.new(value)
          return node.right_child
        else
          return insert(value, node.right_child)
        end
      else
        return node
      end
    end
    
  end
  
end