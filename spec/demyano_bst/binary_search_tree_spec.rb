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
  
end
