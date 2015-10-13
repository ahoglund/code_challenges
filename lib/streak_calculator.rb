class StreakCalculator

  def initialize(grades)
    @grades = grades
    @longest_streak = 0
    @current_streak = 1
  end

  attr_reader :longest_streak

  def calculate
    return @longest_streak unless @grades.any?
    (1..(@grades.length - 1)).each do |grade|
      unless @grades[grade] >= @grades[grade - 1]
        @longest_streak = @current_streak if @current_streak > @longest_streak
        @current_streak = 0
      end
      @current_streak += 1
    end
    # for all upward and all same
    @longest_streak = @current_streak if @longest_streak == 0
  end
end