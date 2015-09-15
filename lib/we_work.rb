
# WeWork Coding Challenge - Revenue and Capacity Calculation

# You're given a CSV file ( s3.amazonaws.com/misc-ww/data.csv ) containing office reservation data. Each line represents a reservation of a unique office.
# There're four columns in each line: Capacity, Monthly Price, Start Day, and End Day. 
# The fourth column "End Day" could be empty, meaning the office is indefinitely reserved starting from the Start Day. 

# Please fork this script(use the fork button at top left) and write a script using the language of your choice that answers the following questions.
# 1) Given a month and a year, what is the revenue for the given month?
# 2) Given a month and a year, what is the total capacity of the unreserved offices for the given month? 

# When you are complete please send us the link to your script. We'll use the following inputs to test your code. The input will be in this format: YYYY-MM
# 1) 2000-01  (expected revenue: $0.00, expected total capacity of the unreserved offices: 266)
# 2) 2018-01 (expected revenue: $77,000.00, expected total capacity of the unreserved offices: 135)
# 3) 2013-01 
# 4) 2014-08

# Notes:
# 1) Unreserved offices are the offices that are not reserved for a single day for the given month. 
# 2) If an office is partially reserved for a given month, the revenue should be prorated based on the monthly price. For example: 2, 1500, 2014-05-01, 2014-05-15 counts as $750 in revenue for May because the reservation was for half of the month.
# 3) For simplicity sake you can include the CSV file as heredoc in your script.
# 4) After forking the project you'll be able to choose language at the bottom left. 
# 5) After forking the project and clicking 'ideone it!', a new url will be generated. That is the link you need to send us after you complete the challenge.

# @csv = <<CSV
# Capacity,MonthlyPrice,StartDay,EndDay
# 1,600,2014-07-01,
# 1,400,2014-04-02,
# 1,400,2014-05-01,
# 5,2800,2014-03-01,2014-04-30
# 2,1500,2014-05-01,2014-06-30
# 4,1700,2014-04-01,
# 3,1300,2014-04-01,
# 15,6500,2014-05-01,2014-08-31
# 1,400,2014-05-01,
# 1,400,2014-05-01,
# 3,1400,2014-05-01,
# 18,7200,2014-05-01,
# 1,800,2014-06-01,
# 1,700,2014-05-01,2014-06-30
# 2,1250,2014-04-16,2014-06-02
# 1,600,2013-11-01,2014-05-31
# 8,4000,2014-06-02,2014-07-31
# 2,1300,2014-05-01,2014-10-31
# 4,2200,2014-05-01,
# 14,11875,2014-06-01,
# 2,1500,2014-05-01,2014-08-31
# 2,1500,2012-06-01,
# 3,1850,2014-04-09,2014-08-06
# 2,1100,2014-05-01,2014-09-30
# 1,625,2014-04-11,
# 1,1000,2014-02-14,
# 1,400,2014-05-01,
# 6,3600,2014-04-02,
# 2,950,2013-02-01,2014-05-31
# 4,2500,2013-06-01,2014-04-30
# 2,1200,2014-07-01,2014-08-31
# 1,950,2014-06-01,2014-08-31
# 4,3200,2014-04-01,2014-09-30
# 1,400,2014-03-27,2014-04-10
# 4,2600,2014-02-01,2014-04-08
# 11,5500,2014-05-01,
# 2,1200,2014-05-01,2014-07-02
# 1,600,2014-05-01,2014-07-31
# 1,800,2013-11-01,2014-04-30
# 1,700,2013-05-01,
# 2,900,2014-07-01,2014-08-31
# 2,1400,2014-04-02,
# 2,1500,2014-05-01,
# 2,1200,2014-05-01,
# 2,1500,2014-05-01,2014-10-31
# 2,900,2014-02-01,
# 1,400,2014-04-14,
# 2,900,2014-01-01,2014-06-30
# 2,1000,2013-12-01,2014-06-30
# 9,4500,2014-02-06,2014-04-30
# 4,2500,2013-08-01,
# 6,2900,2013-05-01,2014-05-31
# 1,600,2014-04-09,
# 2,1700,2014-02-14,2014-04-30
# 2,900,2014-07-01,
# 1,400,2014-05-01,2014-10-31
# 2,0,2014-04-15,2014-05-01
# 4,2500,2014-05-01,
# 4,3600,2014-05-01,
# 9,4950,2014-05-01,
# 2,1100,2014-05-12,
# 6,2700,2014-05-01,2014-08-31
# 16,350,2014-04-01,2014-08-31
# 2,1300,2012-10-01,
# 1,950,2014-06-01,2014-06-08
# 3,2000,2014-06-01,2014-06-30
# 8,3600,2014-07-08,
# 6,5400,2014-05-12,
# 4,2700,2013-09-01,
# 4,2600,2012-06-01,2014-05-31
# 4,2700,2012-07-01,2014-04-30
# 1,450,2014-04-02,
# 4,2700,2014-04-01,2014-04-30
# 4,2200,2014-06-01,2014-10-31
# CSV

# class Reservation
#   def initialize(start_date:, end_date:)

#   end
# end

# class Office
#   def initialize(capacity:)
#   end
# end

class RevenueAndCapacityCalculator

  def initialize(date:, data:)
    @data         = data
    @year, @month = date.split('-')
    @data_object  = build_data_object

  end

  def total_revenue
    total_revenue = 0

     if @data_object.keys.max < @year
        #iterate all years
       @data_object.keys.each do |y|     
         if @data_object.has_key?(y) && @data_object[y].has_key?(@month)
           @data_object[y].keys.each do |m|
             total_revenue += @data_object[y][m][:revenue]
          end
         end
       end
     elsif @data_object.keys.min < @year
        # before data existed, no price
       total_revenue = 0.00
     else
       #calculate from min until the specified year
     end
     total_revenue
  end

  def unreserved_capacity

  end

  protected

  #
  # returns an array of hashes.  each entry corresponds
  # to the unique office reservation in the data file
  # the has contains the relevant data (capacity, start date, end date)
  #
  def build_data_object
    @total_revenue = 0
    data_object = {}
    @data_array = @data.split("\n")
    @headers = @data_array.shift.split(',')
    @data_array.each do |line|
      if line.length != @headers.length
        #add edit time automatically
      end
      capacity, price, start_date, end_date = line.split(",")
      start_y,start_m,start_d = start_date.split("-")
      end_y,end_m,end_d = end_date.split("-") if end_date
      data_object[start_y] ||= {}
      data_object[start_y][start_m] ||= {}
      data_object[start_y][start_m][:revenue] ||= 0
      data_object[start_y][start_m][:revenue] += prorated_price(monthly_price:, start_date:, end_date:)
    end
    data_object
  end

  def prorated_price(monthly_price:, start_date:, end_date:)
    # monthly price / days in month = price per day
    # calculate partial date ranges for a given month and count those days
    # price per day * total days reserved
  end

  def days_in_month
    year_days = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if month == 2 && ::Date.gregorian_leap?(@year)
      29
    else
      year_days[@month]
    end
  end
end