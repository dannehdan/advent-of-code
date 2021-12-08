# @input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
@input = File.read('./day-7/input.txt').split(',').map(&:to_i)

def run
  fuel_test = []
  mean = (@input.sum / @input.count)
  stdev = Math.sqrt(@input.sum / (@input.count - 1)).floor
  (mean - stdev..mean + stdev).each do |x|
    fuel = 0
    @input.each do |value|
      n = (value - x).abs
      fuel += (n * (n + 1)) / 2
    end
    fuel_test << fuel
  end
  p fuel_test.min
end

run
