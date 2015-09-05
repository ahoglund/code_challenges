require 'streak_calculator'

RSpec.describe StreakCalculator, "#calculate" do 

  expectations = [
    [4, [9,7,8,2,5,5,8,7]],
    [4, [1,2,3,4]],
    [1, [5,4,3,2,1]],
    [11,[3,3,3,3,3,3,3,3,3,3,3]],
    [6, [1,7,2,5,6,9,11,11,1,6,1]],
    [6, [6,7,5,3,6,6,8,9,11,3,3,3]],
  ]

  expectations.each do |expectation|
    streak, run = expectation[0], expectation[1]
    context "with #{run} as run" do
      it "should calculate the longest streak to #{streak}" do
        streak_calculator = StreakCalculator.new(run)
        streak_calculator.calculate
        expect(streak_calculator.longest_streak).to eq streak
      end
    end
  end
end