class ParenthesisMatcher

  attr_accessor :string
  attr_accessor :start_parenthesis_position

  def match
  	raise "Unbalanced parenthesis" if unbalanced?
  	raise "Not a starting parenthesis" unless given_a_starting_parenthesis?

    level = 0
    start_level = 0
    end_parenthesis_position = 0
    
    string.split("").each_with_index do |c,i| 
    	if c == "("
        if i == start_parenthesis_position - 1
          start_level = level
        end
        level += 1 
    	elsif c == ")"
        level -= 1
        if level == start_level && i >= start_parenthesis_position - 1
        	end_parenthesis_position = i + 1
        	break
        end
	    end
    end
    end_parenthesis_position
  end

  private 

  def split_string
  	@split_string ||= string.split("")
  end

  def given_a_starting_parenthesis?
   split_string[start_parenthesis_position - 1] == "("
  end

  def unbalanced?
    parenthesis_stack = []
    split_string.each {|c| c == "(" ? parenthesis_stack << c : c == ")" ? parenthesis_stack.pop : nil }
    parenthesis_stack.any?
  end
end