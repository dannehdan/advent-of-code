$test = [
  "00100",
  "11110",
  "10110",
  "10111",
  "10101",
  "01111",
  "00111",
  "11100",
  "10000",
  "11001",
  "00010",
  "01010",
]

class Binary
  def initialize
    @gamma = []
    @epsilon = []
    # @input = File.readlines("./day-3/input.txt").map(&:chomp)
    @input = $test
  end
  