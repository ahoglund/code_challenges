def longest_improvement(grades)
    longest_streak = []
    current_streak = []
    (1..(grades.length - 1)).each do |i|
      if grades[i] >= grades[i - 1]
        current_streak << grades[i - 1]
      else
        current_streak << grades[i - 1]
        if current_streak.length > longest_streak.length
          longest_streak = current_streak
        end
        current_streak = []
      end
    end
    longest_streak
end

grades = [6, 7, 5, 3, 6, 6, 8, 9, 11, 3, 3, 3]

puts longest_improvement(grades)
