module DemyanoBst
  
  class BinarySearchTree
    
    include Enumerable

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
          node.left_child = Node.new(value, node)
          return node.left_child
        else
          return insert(value, node.left_child)
        end
      elsif value > node.value
        if node.right_child.nil?
          node.right_child = Node.new(value, node)
          return node.right_child
        else
          return insert(value, node.right_child)
        end
      else
        return node
      end
    end
    
    def each(node = root)
      return if node.nil?
      each(node.left_child) { |value| yield(value) }
      yield node.value
      each(node.right_child) { |value| yield(value) }
    end

    def delete(value)
      found = search(value)
      return if found.nil?
      if found.leaf?
        if found.root?
          @root = nil
        else
          found.parent.delete(found)
        end
      elsif child = found.only_child
        child.parent = found.parent

        if found.parent
          if found.parent.left_child == found
            found.parent.left_child = child
          else
            found.parent.right_child = child
          end
        else
          @root = child
        end
      else
        predecessor = found.predecessor
        original_predecessor_parent = predecessor.parent

        if found.left_child != predecessor
          predecessor.left_child = found.left_child
          predecessor.left_child.parent = predecessor
        end
        predecessor.right_child = found.right_child
        predecessor.right_child.parent = predecessor

        if found.parent.left_child == found
          found.parent.left_child = predecessor
        else
          found.parent.right_child = predecessor
        end

        predecessor.parent = found.parent
        original_predecessor_parent.delete(predecessor)
      end
    end

  end

end