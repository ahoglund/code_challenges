require 'parenthesis_matcher'

RSpec.describe ParenthesesMatcher do 

  describe "#match" do 
    context "position not a parentheses" do
 
      let(:matcher) { ParenthesesMatcher.new("doesnt matter",2) }

      it "raises an error" do 
        expect {
          matcher.match
        }.to raise_error
      end
    end

    context "string with unbalanced parentheses" do

      let(:matcher) { ParenthesesMatcher.new("()))(",1) }

      it "raises an error" do 
        expect {
          matcher.match
        }.to raise_error
      end
    end

    context "string with balanced parentheses" do
      it "should return 6" do 
        matcher = ParenthesesMatcher.new("(asdf)",1)
        expect(matcher.match).to eq 6
      end

      it "should return 4" do 
        matcher = ParenthesesMatcher.new("(())",1)
        expect(matcher.match).to eq 4
      end

      it "should return 15" do 
        matcher = ParenthesesMatcher.new("()()()()()()(())",14)
        expect(matcher.match).to eq 15
      end

      it "should return 24" do 
        matcher = ParenthesesMatcher.new("((()()()()()()()()((()))()()()()))",19)
        expect(matcher.match).to eq 24
      end
    end
  end
end