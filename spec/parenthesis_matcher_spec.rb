require 'parenthesis_matcher'

RSpec.describe ParenthesisMatcher do 

  describe "#match" do 
    context "position not a parenthesis" do
 
      let(:matcher) { ParenthesisMatcher.new("doesnt matter",2) }

      it "raises an error" do 
        expect {
          matcher.match
        }.to raise_error
      end
    end

    context "string with unbalanced parenthesis" do

      let(:matcher) { ParenthesisMatcher.new("()))(",1) }

      it "raises an error" do 
        expect {
          matcher.match
        }.to raise_error
      end
    end

    context "string with balanced parenthesis" do
      it "should return 6" do 
        matcher = ParenthesisMatcher.new("(asdf)",1)
        expect(matcher.match).to eq 6
      end

      it "should return 4" do 
        matcher = ParenthesisMatcher.new("(())",1)
        expect(matcher.match).to eq 4
      end

      it "should return 15" do 
        matcher = ParenthesisMatcher.new("()()()()()()(())",14)
        expect(matcher.match).to eq 15
      end

      it "should return 24" do 
        matcher = ParenthesisMatcher.new("((()()()()()()()()((()))()()()()))",19)
        expect(matcher.match).to eq 24
      end
    end
  end
end