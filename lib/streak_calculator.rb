class StreakCalculator

  def initialize(grades)
    @grades = grades
    @longest_streak = 0
  end

  attr_reader :longest_streak

  def calculate
    current_streak = []
    (1..(@grades.length - 1)).each do |i|
      if @grades[i] >= @grades[i - 1]
        current_streak << @grades[i - 1]
      else
        current_streak << @grades[i - 1]
        if current_streak.length > @longest_streak
          @longest_streak = current_streak.length
        end
        # reset the streak
        current_streak = []
      end
    end
    # for when the steak only goes upwards, never down
    if @longest_streak == 0
      current_streak << @grades.last
      @longest_streak = current_streak.length
    end
  end
end