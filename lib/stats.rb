class Stats

  def self.fetch(*opts)
    Stats.new(opts)
  end

  def initialize(opts)
    @stats = opts
    run_stats
  end

  def run_stats
    @stats.any? ? run_selected_stats : run_all_stats
  end

  def run_selected_stats
    @stats.each { |stat| send("set_#{stat}".to_sym) }
  end

  def run_all_stats
    setter_methods = methods.grep /set_/
    setter_methods.each do |method|
      send(method)
    end
  end

  attr_reader :stat_one
  attr_reader :stat_two
  attr_reader :stat_three

  def set_stat_one
    @stat_one = 1000
  end

  def set_stat_two
    @stat_two = 2000
  end

  def set_stat_three
    @stat_three = 3000
  end
end
