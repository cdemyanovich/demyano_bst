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
    
    # Implementing #each and including Enumerable provides #sort (among others)
    def each(node = root)
      return if node.nil?
      each(node.left_child) { |value| yield value }
      yield node.value
      each(node.right_child) { |value| yield value }
    end

    def delete(value)
      condemned = search(value)
      return if condemned.nil?

      if condemned.leaf?
        if condemned.root?
          @root = nil
        else
          condemned.parent.disown(condemned)
        end
      elsif replacement = condemned.only_child
        condemned.replace_in_parent(replacement)
        @root = replacement if condemned.root?
      else
        replacement = condemned.in_order_predecessor
        replacement_parent = replacement.parent
        replacement.adopt_children_of(condemned)
        condemned.replace_in_parent(replacement)
        replacement_parent.disown(replacement)
      end
    end

  end

end