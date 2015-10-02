require 'stats'

RSpec.describe Stats do
  
  subject { Stats }
  it { is_expected.to respond_to :fetch }

  let(:all_stats) { [:stat_one, :stat_two, :stat_three] }

  describe ".fetch" do 
    it "defaults to all stats" do
      stats = Stats.fetch
      all_stats.each do |stat|
        expect(stats).to respond_to stat
      end
      binding.pry
    end

    it "responds to passed stats" do 
      stats = Stats.fetch(:stat_one, :stat_two)
      expect(stats).to respond_to(:stat_one)
      expect(stats).to respond_to(:stat_two)
    end

    it "returns nil for non passed stat" do
      stats = Stats.fetch(:stat_one)
      expect(stats.stat_two).to eq nil
    end

    it "returns a stat" do
      stats = Stats.fetch(:stat_one)
      expect(stats.stat_one).to eq 1000
    end
  end
end