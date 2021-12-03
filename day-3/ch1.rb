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
    @input = File.readlines("./day-3/input.txt").map(&:chomp)
  end

  def gamma
    i = 0
    while i < @input[0].length
      tmp = []
      one = 0
      zero = 0
      @input.each do |thing|
        tmp << thing[i]
      end
      tmp.each do |this|
        this == "1" ? one += 1 : zero += 1
      end
      one > zero ? @gamma << "1" : @gamma << "0"
      i += 1
    end
    @gamma.join("")
  end

  def epsilon
    @epsilon = []
    @gamma.each do |switch|
      switch == "1" ? @epsilon << "0" : @epsilon << "1"
    end
    @epsilon
  end

  def answer
    p @gamma.join("").to_i(2) * @epsilon.join("").to_i(2)
  end
end

list = Binary.new
list.gamma
list.epsilon
list.answer
