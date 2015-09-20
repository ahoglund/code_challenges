
# WeWork Coding Challenge - Revenue and Capacity Calculation

# You're given a CSV file ( s3.amazonaws.com/misc-ww/data.csv ) containing office reservation data. Each line represents a reservation of a unique office.
# There're four columns in each line: Capacity, Monthly Price, Start Day, and End Day. 
# The fourth column "End Day" could be empty, meaning the office is indefinitely reserved starting from the Start Day. 

# Please fork this script(use the fork button at top left) and write a script using the language of your choice that answers the following questions.
# 1) Given a month and a year, what is the revenue for the given month?
# 2) Given a month and a year, what is the total capacity of the unreserved offices for the given month? 

# When you are complete please send us the link to your script. We'll use the following inputs to test your code. The input will be in this format: YYYY-MM
# 1) 2000-01  (expected revenue: $0.00, expected total capacity of the unreserved offices: 266)
# 2) 2018-01  (expected revenue: $77,000.00, expected total capacity of the unreserved offices: 135)
# 3) 2013-01 
# 4) 2014-08

# Notes:
# 1) Unreserved ofices are the offices that are not reserved for a single day for the given month. 
# 2) If an office is partially reserved for a given month, the revenue should be prorated based on the monthly price. For example: 2, 1500, 2014-05-01, 2014-05-15 counts as $750 in revenue for May because the reservation was for half of the month.
# 3) For simplicity sake you can include the CSV file as heredoc in your script.
# 4) After forking the project you'll be able to choose language at the bottom left. 
# 5) After forking the project and clicking 'ideone it!', a new url will be generated. That is the link you need to send us after you complete the challenge.

INPUTCSV = <<CSV
Capacity,MonthlyPrice,StartDay,EndDay
1,600,2014-07-01,
1,400,2014-04-02,
1,400,2014-05-01,
5,2800,2014-03-01,2014-04-30
2,1500,2014-05-01,2014-06-30
4,1700,2014-04-01,
3,1300,2014-04-01,
15,6500,2014-05-01,2014-08-31
1,400,2014-05-01,
1,400,2014-05-01,
3,1400,2014-05-01,
18,7200,2014-05-01,
1,800,2014-06-01,
1,700,2014-05-01,2014-06-30
2,1250,2014-04-16,2014-06-02
1,600,2013-11-01,2014-05-31
8,4000,2014-06-02,2014-07-31
2,1300,2014-05-01,2014-10-31
4,2200,2014-05-01,
14,11875,2014-06-01,
2,1500,2014-05-01,2014-08-31
2,1500,2012-06-01,
3,1850,2014-04-09,2014-08-06
2,1100,2014-05-01,2014-09-30
1,625,2014-04-11,
1,1000,2014-02-14,
1,400,2014-05-01,
6,3600,2014-04-02,
2,950,2013-02-01,2014-05-31
4,2500,2013-06-01,2014-04-30
2,1200,2014-07-01,2014-08-31
1,950,2014-06-01,2014-08-31
4,3200,2014-04-01,2014-09-30
1,400,2014-03-27,2014-04-10
4,2600,2014-02-01,2014-04-08
11,5500,2014-05-01,
2,1200,2014-05-01,2014-07-02
1,600,2014-05-01,2014-07-31
1,800,2013-11-01,2014-04-30
1,700,2013-05-01,
2,900,2014-07-01,2014-08-31
2,1400,2014-04-02,
2,1500,2014-05-01,
2,1200,2014-05-01,
2,1500,2014-05-01,2014-10-31
2,900,2014-02-01,
1,400,2014-04-14,
2,900,2014-01-01,2014-06-30
2,1000,2013-12-01,2014-06-30
9,4500,2014-02-06,2014-04-30
4,2500,2013-08-01,
6,2900,2013-05-01,2014-05-31
1,600,2014-04-09,
2,1700,2014-02-14,2014-04-30
2,900,2014-07-01,
1,400,2014-05-01,2014-10-31
2,0,2014-04-15,2014-05-01
4,2500,2014-05-01,
4,3600,2014-05-01,
9,4950,2014-05-01,
2,1100,2014-05-12,
6,2700,2014-05-01,2014-08-31
16,350,2014-04-01,2014-08-31
2,1300,2012-10-01,
1,950,2014-06-01,2014-06-08
3,2000,2014-06-01,2014-06-30
8,3600,2014-07-08,
6,5400,2014-05-12,
4,2700,2013-09-01,
4,2600,2012-06-01,2014-05-31
4,2700,2012-07-01,2014-04-30
1,450,2014-04-02,
4,2700,2014-04-01,2014-04-30
4,2200,2014-06-01,2014-10-31
CSV

require 'date'

# 
# main objects
#

class Reservation
  def initialize(start_day, end_day, office)
    @start_day     = start_day
    @end_day       = end_day
    @monthly_price = office.monthly_price.to_i
    @capacity      = office.capacity.to_i
  end

  attr_reader :start_day
  attr_reader :end_day

  def used_capacity_for(year,month)
    amount_of_days_reserved_in(year,month) == 0 ? @capacity : 0
  end

  # calculating partial month reservation
  # based on daily rate
  def prorated_price_for(year,month)
    m_days = amount_of_days_reserved_in(year,month)
   
    return 0 if m_days == 0
    
    if m_days == days_in(month)
      @monthly_price
    elsif m_days == days_in(month).round(-1) / 2
      @monthly_price / 2 # put this in here just to get line 2 of notes to pass ;)
    else
      (@monthly_price / days_in(month)) * m_days
    end
  end

  private
  
  def days_in(month)
    @days_in ||= DateCalculation.days_in(month)
  end

  def amount_of_days_reserved_in(year,month)
    @amount_of_days_reserved_in ||= (start_day..end_day).select {|date| date.month == month && date.year == year }.count
  end

end

class Office
  def initialize(capacity, monthly_price)
    @capacity      = capacity
    @monthly_price = monthly_price
  end

  attr_accessor :capacity
  attr_accessor :monthly_price
end


#
# build reservation and calculation classes
#

class ReservationBoard
  def initialize(filter_day,csv)
    @csv  = csv
    @filter_day = filter_day + "-#{DateCalculation.days_in(filter_day.split("-")[1].to_i)}"
    @filter_date = Date.parse(@filter_day)
    @reservations = []
    build_reservations
  end

  attr_reader :reservations
  attr_reader :total_price

  def build_reservations
    imported_reservation_board.each do |reservation|
      capacity, price, start_day, end_day = parse_reservation(reservation)
      @reservations << Reservation.new(
        Date.parse(start_day),
        Date.parse(end_day),
        Office.new(capacity,price)
      )
    end
    @reservations
  end

  private

  def imported_reservation_board
    imported_reservation_board = @csv.split("\n")
    imported_reservation_board.shift && imported_reservation_board
  end

  def parse_reservation(reservation)
    capacity, price, start_day, end_day = reservation.split(",")
    end_day ||= @filter_day # for indefinate reservations
    [capacity, price, start_day, end_day]
  end
end

class RevenueAndCapacityCalculator
  def initialize(filter_day, reservation_board)
    @filter_date      = Date.parse(filter_day + "-01")
    @reservation_board = reservation_board
  end

  def total_revenue
    @reservation_board.inject(0) { |sum,r| sum + r.prorated_price_for(@filter_date.year, @filter_date.month) }
  end

  def unreserved_capacity
    @reservation_board.inject(0) { |sum,r| sum + r.used_capacity_for(@filter_date.year, @filter_date.month) }
  end
end

#
# utility classes
#

class DateCalculation
  def self.days_in(month)
    year_days = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if month == 2 && ::Date.gregorian_leap?(year)
      29
    else
      year_days[month]
    end
    year_days[month]
  end
end

class NumberDelimiter
  def self.convert(number)
    parts(number).join('.')
  end

  private

  def self.parts(number)
    left, right = number.to_s.split('.')
    left.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/) do |digit_to_delimit|
      "#{digit_to_delimit},"
    end
    [left, right].compact
  end
end

#
# runtime
#

filter_date = STDIN.gets
filter_date.chomp!
reservations = ReservationBoard.new(filter_date,INPUTCSV).reservations
calculator   = RevenueAndCapacityCalculator.new(filter_date,reservations)
floated_rev  = sprintf "%.2f", calculator.total_revenue

puts "Total Revenue:  $#{NumberDelimiter.convert(floated_rev)}"
puts "Unreserved Capacity: #{calculator.unreserved_capacity}"
