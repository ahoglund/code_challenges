require 'stats'

RSpec.describe Stats do
  
  subject { Stats }
  it { is_expected.to respond_to :fetch }

  let(:all_stats) { [:two_plus_two, :four_plus_four, :three_times_two] }

  describe ".fetch" do 
    it "defaults to all stats" do
      stats = Stats.fetch
      all_stats.each do |stat|
        expect(stats).to respond_to stat
      end
    end

    it "responds to passed stats" do 
      stats = Stats.fetch(:two_plus_two, :four_plus_four)
      expect(stats).to respond_to(:two_plus_two)
      expect(stats).to respond_to(:four_plus_four)
    end

    it "returns nil for non passed stat" do
      stats = Stats.fetch(:two_plus_two)
      expect(stats.four_plus_four).to eq nil
    end

    it "returns a stat" do
      stats = Stats.fetch(:two_plus_two)
      expect(stats.two_plus_two).to eq 4
    end
  end
end