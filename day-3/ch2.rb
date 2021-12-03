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
    @oxygen = []
    @coscrub = []
    @input = File.readlines("./day-3/input.txt").map(&:chomp)
  end

  def oxygen
    @input.map { |num| @oxygen << num }
    i = 0
    while @oxygen.length > 1
      val = 0
      one = 0
      zero = 0
      @oxygen.each do |digit|
        digit[i] == "1" ? one += 1 : zero += 1
      end
      one >= zero ? val = "0" : val = "1"
      (@oxygen.reject! { |k| k[i] == val })
      i += 1
    end
    p @oxygen
    @oxygen
  end

  def scrub
    @input.map { |num| @coscrub << num }
    i = 0
    while @coscrub.length > 1
      val = 0
      one = 0
      zero = 0
      @coscrub.each do |digit|
        digit[i] == "1" ? one += 1 : zero += 1
      end
      one < zero ? val = "0" : val = "1"
      (@coscrub.reject! { |k| k[i] == val })
      i += 1
    end
    p @coscrub
    @coscrub
  end

  def answer
    p @oxygen.join("").to_i(2) * @coscrub.join("").to_i(2)
  end
end

list = Binary.new
list.oxygen
list.scrub
list.answer
