# @input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
@input = File.read('./day-7/input.txt').split(',').map(&:to_i)

def run
  fuel = 0
  sorted = @input.sort
  median = sorted[sorted.length / 2]
  @input.each do |value|
    fuel += (value - median).abs
  end
  p fuel
end

run
