require 'parenthesis_matcher'

RSpec.describe ParenthesisMatcher do 

  describe "#" do 

    subject(:matcher) { ParenthesisMatcher.new }

    it { is_expected.to respond_to :match  }
    it { is_expected.to respond_to :string }
    it { is_expected.to respond_to :start_parenthesis_position }

    context "position not a parenthesis" do
      before do 
        matcher.string = "doesnt matter"
        matcher.start_parenthesis_position = 2
      end
      it "raises an error" do 
        expect {
          matcher.match
        }.to raise_error
      end
    end

    context "string with unbalanced parenthesis" do
      before do 
        matcher.string = "()))("
        matcher.start_parenthesis_position = 1
      end
      it "raises an error" do 
        expect {
          matcher.match
        }.to raise_error
      end
    end

    context "string with balanced parenthesis" do
      it "should return 6" do 
        matcher.string = "(asdf)"
        matcher.start_parenthesis_position = 1
        expect(matcher.match).to eq 6
      end

      it "should return 4" do 
        matcher.string = "(())"
        matcher.start_parenthesis_position = 1
        expect(matcher.match).to eq 4
      end

      it "should return 15" do 
        matcher.string = "()()()()()()(())"
        matcher.start_parenthesis_position = 14
        expect(matcher.match).to eq 15
      end

      it "should return 24" do 
        matcher.string = "((()()()()()()()()((()))()()()()))"
        matcher.start_parenthesis_position = 19
        expect(matcher.match).to eq 24
      end
    end
  end
end