module DemyanoBst
  
  class Node
    
    attr_reader :value
    attr_accessor :left_child, :right_child
    
    def initialize(value)
      @value = value
    end
    
  end
  
end
