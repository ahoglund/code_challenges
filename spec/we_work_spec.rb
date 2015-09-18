require 'we_work'
CSV = <<CSV
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


RSpec.describe Reservation do
  context "2,1500,2014-05-01,2014-05-15" do
    before(:all) do
      office       = Office.new(2, 1500)
      @reservation = Reservation.new("2014-05-01", "2014-05-15", office.monthly_price)
    end

    it "should return $50 for daily_price" do
      expect(@reservation.instance_eval { daily_price }).to eq 50
    end

    it "should return 15 for total_days" do
      expect(@reservation.instance_eval { total_days }).to eq 15
    end

    it "should return $750 for total" do
      expect(@reservation.total).to eq 750
    end
  end

  context "1,600,2013-11-01,2014-05-31" do
    before(:all) do
      office       = Office.new(1, 600)
      @reservation = Reservation.new("2013-11-01", "2014-05-31", office.monthly_price)
    end
    it "should return $20 for daily_price" do
      expect(@reservation.instance_eval { daily_price }).to eq 20
    end

    it "should return 212 for total_days" do
      expect(@reservation.instance_eval { total_days }).to eq 212
    end

    it "should return $4240 for total" do
      expect(@reservation.total).to eq 4240
    end
  end

  context "1,950,2014-06-01,2014-06-08" do
    before(:all) do
      office       = Office.new(1, 950)
      @reservation = Reservation.new("2014-06-01", "2014-06-08", office.monthly_price)
    end
    it "should return $31 for daily_price" do
      expect(@reservation.instance_eval { daily_price }).to eq 31
    end

    it "should return 8 for total_days" do
      expect(@reservation.instance_eval { total_days }).to eq 8
    end

    it "should return $248 for total" do
      expect(@reservation.total).to eq 248
    end
  end

end

RSpec.describe RevenueCalculator do
  context "Given a month and a year of 2000-01" do
    before(:all) do
      @reservations = ReservationList.new(CSV)
    end

    it "should have a revenue: $0.00" do
      @calculator = RevenueCalculator.new("2000-01", @reservations)
      expect(@calculator.total_revenue).to eq 0
    end

    it "should have a revenue: $77,000.00" do
      @calculator = RevenueCalculator.new("2018-01", @reservations)
      expect(@calculator.total_revenue).to eq 77000
    end
  end
end


# it "should capacity of the unreserved offices: 266" do
#   @calculator = MonthlyCapacityCalculator.new(date: "2000-01", data: CSV)
#   expect(@calculator.unreserved_capacity).to eq "266"
# end
# end

# context "Given a month and a year of 2018-01" do



#   it "should capacity of the unreserved offices: 135" do
#     @calculator = CapacityCalculator.new(date: "2018-01", data: CSV)
#     expect(@calculator.unreserved_capacity).to eq "135"
#   end
# end

# pending "2013-01"
# pending "2014-08"
# end
