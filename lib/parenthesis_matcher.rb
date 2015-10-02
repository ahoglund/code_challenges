class ParenthesesMatcher

  def initialize(string, start_parentheses_position)
    @string = string
    @start_parentheses_position = start_parentheses_position - 1

    raise "Not a starting parentheses" unless given_a_starting_parentheses?
    raise "Unbalanced parentheses" if unbalanced?
  end

  def match
    find_matching_parentheses(0,0)
  end

  private 
  
  def find_matching_parentheses(level, match_level)
      split_string.each_with_index do |c,i| 
      if c == "("
        match_level = level if i == @start_parentheses_position
        level += 1 
      elsif c == ")"
        level -= 1
        return i + 1 if level == match_level && i >= @start_parentheses_position
      end
    end
  end

  def split_string
  	@split_string ||= @string.split("")
  end

  def given_a_starting_parentheses?
   split_string[@start_parentheses_position] == "("
  end

  def unbalanced?
    parentheses_stack = []
    split_string.each {|c| c == "(" ? parentheses_stack << c : c == ")" ? parentheses_stack.pop : nil }
    parentheses_stack.any?
  end
end