require 'spec_helper'

module DemyanoBst
  
  describe Node, '#root?' do
    
    it "is true if node has no parent" do
      node = Node.new(3)
      node.should be_root
    end
    
    it "is false if node has parent" do
      node_3 = Node.new(3)
      node_1 = Node.new(1, node_3)
      node_1.should_not be_root
    end
  end
  
  describe Node, '#leaf?' do
    
    it "is true if the node has no children" do
      node = Node.new(3)
      node.left_child = nil
      node.right_child = nil
      node.should be_leaf
    end
    
    it "is false if the node has only a left child" do
      node = Node.new(3)
      node.left_child = Node.new(1)
      node.right_child = nil
      node.should_not be_leaf
    end
    
    it "is false if the node has only a right child" do
      node = Node.new(3)
      node.left_child = nil
      node.right_child = Node.new(4)
      node.should_not be_leaf
    end
    
    it "is false if the node has both a left and right child" do
      node = Node.new(3)
      node.left_child = Node.new(1)
      node.right_child = Node.new(4)
      node.should_not be_leaf
    end
    
  end
  
  describe Node, '#only_child' do
    
    it "returns nil if node is a leaf" do
      node_3 = Node.new(3)
      node_3.only_child.should be_nil
    end
    
    it "returns nil if node has two children" do
      node_3 = Node.new(3)
      node_3.left_child = Node.new(1)
      node_3.right_child = Node.new(4)
      node_3.only_child.should be_nil
    end
    
    it "returns left child if node has only left child" do
      node_3 = Node.new(3)
      node_1 = Node.new(1)
      node_3.left_child = node_1
      node_3.only_child.should == node_1
    end
    
    it "returns right child if node has only right child" do
      node_3 = Node.new(3)
      node_4 = Node.new(4)
      node_3.right_child = node_4
      node_3.only_child.should == node_4
    end
    
  end
  
  describe Node, '#in_order_predecessor' do
    
    it "is nil if node is a leaf" do
      node_3 = Node.new(3)
      node_3.in_order_predecessor.should be_nil
    end
    
    it "is left child if left child is leaf" do
      node_3 = Node.new(3)
      node_1 = Node.new(1, node_3)
      node_3.left_child = node_1
      node_3.in_order_predecessor.should == node_1
    end
    
    it "is left child's right child if right child is present" do
      node_3 = Node.new(3)
      node_1 = Node.new(1, node_3)
      node_2 = Node.new(2, node_1)
      node_3.left_child = node_1
      node_1.right_child = node_2
      node_3.in_order_predecessor.should == node_2
    end
    
  end

end
