# This class is a very simple generator of time sequences
# 
# Author::    David Horsák
# Copyright:: nevico Ltd (www.nevico.eu)
# Licence::   EUPL
# 
class TimeSequenceGenerator
  
  # The +new+ class method initiliazes the class
  # 
  # == Parameters
  # * _reference_time_ = point in time from which sequence starts
  # * _min_ = minimum lenght in seconds from *n-th* time to *n+1-th* time
  # * _max_ = maximum length in second rom *n-th* time to *n+1-th* time
  #
  # == Example
  # t = TimeSequenceGenerator.new(Time.now, 60, 100)
  # 
  def initialize(reference_time = Time.now, min = 1, max = 100)
    @min_period = min
    @max_period = max
    @times = []
    generate(reference_time, @min_period, @max_period)
  end
  
  # Returns next time in sequence
  # 
  # == Example
  # t = TimeSequenceGenerator.new(Time.utc(2000,"jan",1,20,15,1), 1, 100)
  # t.next  #=> 2000-01-01 20:15:21 UTC
  #
  def next
    if @times.size == 1
      generate(@reference_time, @min_period, @max_period)
      @times.shift
    elsif @times.size == 0
      begin
        sleep(0.00000001)
      end until @times.size > 0
      @times.shift
    else
      @times.shift
    end
  end
  
  private
  
  # Quietly in the background fills the array containing time sequence
  def generate(reference, min, max, n = 100)
    Thread.new do
      diff = max - min
      n.times do |i|
        reference = reference + min + rand(diff)
        @times << reference
        @reference_time = @times.last
      end
    end
  end
end