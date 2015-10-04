class Stats

  STATS = {
    :two_plus_two =>     Proc.new { 2 + 2 },
    :four_plus_four =>   Proc.new { 4 + 4 },
    :three_times_two =>  Proc.new { 3 * 2 }
  }

  STATS.keys.each { |stat| self.class_eval { attr_reader stat } }

  def self.fetch(*opts)
    Stats.new(opts)
  end

  def initialize(opts)
    run_stats(opts)
  end

  def run_stats(opts)
    opts.any? ? run_selected_stats(opts) : run_all_stats
  end

  def run_selected_stats(opts)
    opts.each { |stat| instance_variable_set("@#{stat}", STATS[stat].call)  }
  end

  def run_all_stats
    STATS.each { |stat,proc|  instance_variable_set("@#{stat}", proc.call) }
  end
end
