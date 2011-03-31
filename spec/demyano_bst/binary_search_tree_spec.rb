require 'spec_helper'

module DemyanoBst
  
  describe BinarySearchTree, '.new' do
    
    it "initializes a new instance with nil root node" do
      bst = BinarySearchTree.new
      bst.root.should be_nil
    end
    
    it "initializes a new instance with the given root node" do
      node_3 = Node.new(3)
      bst = BinarySearchTree.new(node_3)
      bst.root.should == node_3
    end
    
  end
  
  describe BinarySearchTree, '#search' do
    
    it "returns nil when the tree is empty" do
      bst = BinarySearchTree.new
      bst.search(3).should be_nil
    end
    
    it "returns nil when no node has the given value" do
      node_3 = Node.new(3)
      bst = BinarySearchTree.new(node_3)
      bst.search(1).should be_nil
    end
    
    it "finds the root node with the given value" do
      node_3 = Node.new(3)
      bst = BinarySearchTree.new(node_3)
      bst.search(3).should == node_3
    end
    
    it "finds a shallow left node" do
      node_3 = Node.new(3)
      node_1 = Node.new(1)
      node_3.left_child = node_1
      bst = BinarySearchTree.new(node_3)
      bst.search(1).should == node_1
    end
    
    it "finds a shallow right node" do
      node_3 = Node.new(3)
      node_4 = Node.new(4)
      node_3.right_child = node_4
      bst = BinarySearchTree.new(node_3)
      bst.search(4).should == node_4
    end
    
    it "finds a deep left node" do
      node_3 = Node.new(3)
      node_9 = Node.new(9)
      node_6 = Node.new(6)
      node_4 = Node.new(4)
      node_3.right_child = node_9
      node_9.left_child = node_6
      node_6.left_child = node_4
      bst = BinarySearchTree.new(node_3)
      bst.search(4).should == node_4
    end
    
    it "finds a deep right node" do
      node_3 = Node.new(3)
      node_9 = Node.new(9)
      node_6 = Node.new(6)
      node_7 = Node.new(7)
      node_3.right_child = node_9
      node_9.left_child = node_6
      node_6.right_child = node_7
      bst = BinarySearchTree.new(node_3)
      bst.search(7).should == node_7
    end
    
  end
  
  describe BinarySearchTree, '#insert' do
    
    it "creates a root node when the tree is empty" do
      bst = BinarySearchTree.new
      node_3 = bst.insert(3)
      node_3.should_not be_nil
      bst.root.should == node_3
    end
    
    it "creates left child node of root for value less than root" do
      node_3 = Node.new(3)
      bst = BinarySearchTree.new(node_3)
      node_1 = bst.insert(1)
      node_1.should_not be_nil
      node_3.left_child.should == node_1
    end
    
    it "creates right child node of root for value greater than root" do
      node_3 = Node.new(3)
      bst = BinarySearchTree.new(node_3)
      node_4 = bst.insert(4)
      node_4.should_not be_nil
      node_3.right_child.should == node_4
    end
    
    it "creates deep left child node" do
      node_3 = Node.new(3)
      node_9 = Node.new(9)
      node_6 = Node.new(6)
      node_3.right_child = node_9
      node_9.left_child = node_6
      bst = BinarySearchTree.new(node_3)
      node_4 = bst.insert(4)
      node_4.should_not be_nil
      node_6.left_child.should == node_4
    end
    
    it "creates deep right child node" do
      node_3 = Node.new(3)
      node_9 = Node.new(9)
      node_6 = Node.new(6)
      node_3.right_child = node_9
      node_9.left_child = node_6
      bst = BinarySearchTree.new(node_3)
      node_7 = bst.insert(7)
      node_7.should_not be_nil
      node_6.right_child.should == node_7
    end
    
    it "returns existing node if value already inserted" do
      node_3 = Node.new(3)
      node_4 = Node.new(4)
      node_3.right_child = node_4
      bst = BinarySearchTree.new(node_3)
      inserted_node_4 = bst.insert(4)
      inserted_node_4.should equal(node_4)
    end
    
  end
  
  describe BinarySearchTree, '#each' do

    it "yields no values when the tree is empty" do
      bst = BinarySearchTree.new
      actual_values = []
      bst.each { |value| actual_values << value }
      actual_values.should == []
    end

    it "yields the values in order" do
      node_3 = Node.new(3)
      node_1 = Node.new(1)
      node_2 = Node.new(2)
      node_4 = Node.new(4)
      node_9 = Node.new(9)
      node_6 = Node.new(6)
      node_7 = Node.new(7)

      node_3.left_child = node_1
      node_1.right_child = node_2

      node_3.right_child = node_4
      node_4.right_child = node_9
      node_9.left_child = node_6
      node_6.right_child = node_7

      actual_values = []
      bst = BinarySearchTree.new(node_3)
      bst.each { |value| actual_values << value }
      actual_values.should == [1, 2, 3, 4, 6, 7, 9]
    end

  end

  describe BinarySearchTree, '#sort' do

    it "returns [] when the tree is empty" do
      bst = BinarySearchTree.new
      bst.sort.should == []
    end

    it "returns a list of only the root value when the tree has only a root" do
      node_3 = Node.new(3)
      bst = BinarySearchTree.new(node_3)
      bst.sort.should == [3]
    end

    it "returns a list of the values in order" do
      node_3 = Node.new(3)
      node_1 = Node.new(1)
      node_2 = Node.new(2)
      node_4 = Node.new(4)
      node_9 = Node.new(9)
      node_6 = Node.new(6)
      node_7 = Node.new(7)

      node_3.left_child = node_1
      node_1.right_child = node_2

      node_3.right_child = node_4
      node_4.right_child = node_9
      node_9.left_child = node_6
      node_6.right_child = node_7

      bst = BinarySearchTree.new(node_3)
      bst.sort.should == [1, 2, 3, 4, 6, 7, 9]
    end

  end

  describe BinarySearchTree, '#delete' do

    it "does nothing if tree is empty" do
      bst = BinarySearchTree.new
      bst.delete(3)
      bst.root.should be_nil
    end

    it "does nothing if the value is not in the tree" do
      node_3 = Node.new(3)
      node_4 = Node.new(4)
      node_3.right_child = node_4
      bst = BinarySearchTree.new(node_3)
      bst.delete(1)
      bst.root.should == node_3
      node_3.right_child.should == node_4
    end

    it "handles a left leaf node" do
      node_3 = Node.new(3)
      node_1 = Node.new(1, node_3)
      node_3.left_child = node_1
      bst = BinarySearchTree.new(node_3)
      bst.delete(1)
      node_3.left_child.should be_nil
    end

    it "handles a right leaf node" do
      node_3 = Node.new(3)
      node_4 = Node.new(4, node_3)
      node_3.right_child = node_4
      bst = BinarySearchTree.new(node_3)
      bst.delete(4)
      node_3.right_child.should be_nil
    end

    it "handles a node with one left child" do
      node_3 = Node.new(3)
      node_9 = Node.new(9, node_3)
      node_7 = Node.new(7, node_9)
      node_3.right_child = node_9
      node_9.left_child = node_7
      bst = BinarySearchTree.new(node_3)
      bst.delete(9)
      node_3.right_child.should == node_7
    end

    it "handles a node with one right child" do
      node_3 = Node.new(3)
      node_1 = Node.new(1, node_3)
      node_2 = Node.new(2, node_1)
      node_3.left_child = node_1
      node_1.right_child = node_2
      bst = BinarySearchTree.new(node_3)
      bst.delete(1)
      node_3.left_child.should == node_2
    end

    it "handles a left node with two children" do
      node_3 = Node.new(3)
      node_1 = Node.new(1, node_3)
      node_0 = Node.new(0, node_1)
      node_2 = Node.new(2, node_1)
      node_3.left_child = node_1
      node_1.left_child = node_0
      node_1.right_child = node_2
      bst = BinarySearchTree.new(node_3)
      bst.delete(1)
      bst.root.should == node_3
      node_3.left_child.should == node_0
      node_0.parent.should == node_3
      node_0.left_child.should be_nil
      node_0.right_child.should == node_2
    end

    it "handles a right node with two children" do
      node_3 = Node.new(3)
      node_9 = Node.new(9, node_3)
      node_7 = Node.new(7, node_9)
      node_11 = Node.new(11, node_9)
      node_3.right_child = node_9
      node_9.left_child = node_7
      node_9.right_child = node_11
      bst = BinarySearchTree.new(node_3)
      bst.delete(9)
      node_3.right_child.should == node_7
      node_7.parent.should == node_3
      node_7.left_child.should be_nil
      node_7.right_child.should == node_11
      node_11.parent.should == node_7
    end

    it "handles a left node with two children with deep predecessor" do
      node_9 = Node.new(9)
      node_10 = Node.new(10, node_9)
      node_5 = Node.new(5, node_9)
      node_8 = Node.new(8, node_5)
      node_3 = Node.new(3, node_5)
      node_1 = Node.new(1, node_3)
      node_4 = Node.new(4, node_3)
      node_9.right_child = node_10
      node_9.left_child = node_5
      node_5.right_child = node_8
      node_5.left_child = node_3
      node_3.right_child = node_4
      node_3.left_child = node_1
      bst = BinarySearchTree.new(node_9)
      bst.delete(5)
      node_9.left_child.should == node_4
      node_4.parent.should == node_9
      node_4.right_child.should == node_8
      node_8.parent.should == node_4
      node_4.left_child.should == node_3
      node_3.parent.should == node_4
      node_3.right_child.should be_nil
    end

    it "handles root node with only left child with 2 children" do
      node_3 = Node.new(3)
      node_1 = Node.new(1, node_3)
      node_0 = Node.new(0, node_1)
      node_2 = Node.new(2, node_1)
      node_3.left_child = node_1
      node_1.left_child = node_0
      node_1.right_child = node_2
      bst = BinarySearchTree.new(node_3)
      bst.delete(3)
      bst.root.should == node_1
      node_1.parent.should be_nil
      node_1.left_child.should == node_0
      node_1.right_child.should == node_2
    end

    it "handles root node with only right child with 2 children" do
      node_3 = Node.new(3)
      node_9 = Node.new(9, node_3)
      node_7 = Node.new(7, node_9)
      node_11 = Node.new(11, node_9)
      node_3.right_child = node_9
      node_9.left_child = node_7
      node_9.right_child = node_11
      bst = BinarySearchTree.new(node_3)
      bst.delete(3)
      bst.root.should == node_9
      node_9.parent.should be_nil
      node_9.left_child.should == node_7
      node_9.right_child.should == node_11
      node_7.parent.should == node_9
      node_11.parent.should == node_9
    end

    it "hanldes root node with no children" do
      node_3 = Node.new(3)
      bst = BinarySearchTree.new(node_3)
      bst.delete(3)
      bst.root.should be_nil
    end

  end

end
