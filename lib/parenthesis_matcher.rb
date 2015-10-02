class ParenthesisMatcher

  def initialize(string, start_parenthesis_position)
    @string = string
    @start_parenthesis_position = start_parenthesis_position - 1

    raise "Not a starting parenthesis" unless given_a_starting_parenthesis?
    raise "Unbalanced parenthesis" if unbalanced?
  end

  def match
    find_matching_parenthesis(0,0)
  end

  private 
  
  def find_matching_parenthesis(level, match_level)
      split_string.each_with_index do |c,i| 
      if c == "("
        match_level = level if i == @start_parenthesis_position
        level += 1 
      elsif c == ")"
        level -= 1
        return i + 1 if level == match_level && i >= @start_parenthesis_position
      end
    end
  end

  def split_string
  	@split_string ||= @string.split("")
  end

  def given_a_starting_parenthesis?
   split_string[@start_parenthesis_position] == "("
  end

  def unbalanced?
    parenthesis_stack = []
    split_string.each {|c| c == "(" ? parenthesis_stack << c : c == ")" ? parenthesis_stack.pop : nil }
    parenthesis_stack.any?
  end
end