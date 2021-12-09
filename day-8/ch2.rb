# @input = ['be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
#           'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
#           'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
#           'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
#           'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
#           'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
#           'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
#           'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
#           'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
#           'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce']
@input = File.readlines('./day-8/input.txt').map(&:chomp)

@decode = { 0 => '', 1 => '', 2 => '', 3 => '', 4 => '', 5 => '', 6 => '', 7 => '', 8 => '', 9 => '' }

def get_output(line)
  tmp = line.split(' | ')
  @code = tmp[0].split(' ')
  @output = tmp[1].split(' ')
end

def known_numbers
  @one = @code.select { |s| (s.length == 2) }
  @four = @code.select { |s| (s.length == 4) }
  @seven = @code.select { |s| (s.length == 3) }
  @eight = @code.select { |s| (s.length == 7) }
  @decode[1] = @one[0]
  @decode[4] = @four[0]
  @decode[7] = @seven[0]
  @decode[8] = @eight[0]
end

def three
  tmp = []
  @code.each do |x|
    if x.length == 5 && x.include?(@decode[1][0]) && x.include?(@decode[1][1])
      @decode[3] = x
    elsif x.length == 5
      tmp << x
    end
  end
  two_five(tmp)
end

def two_five(arr)
  one_three = s_one_three
  if arr[0].include?(one_three[0]) && arr[0].include?(one_three[1])
    @decode[5] = arr[0]
    @decode[2] = arr[1]
  else
    @decode[2] = arr[0]
    @decode[5] = arr[1]
  end
end

def s_one_three
  @four[0].split('') - @one[0].split('')
end

def six
  zero_six_nine = []
  tmp = []
  @code.each do |x|
    zero_six_nine << x if x.length == 6
  end
  zero_six_nine.each do |y|
    if y.include?(@decode[1][0]) && y.include?(@decode[1][1])
      tmp << y
    else
      @decode[6] = y
    end
  end
  zero_nine(tmp)
end

def zero_nine(arr)
  if (arr[0].split('') - @decode[5].split('')).length == 1
    @decode[9] = arr[0]
    @decode[0] = arr[1]
  else
    @decode[9] = arr[1]
    @decode[0] = arr[0]
  end
end

def order_decode
  @decode.map { |k, v| @decode[k] = v.chars.sort.join }
end

def order_output
  @ordered_output = []
  @output.each do |order|
    @ordered_output << order.chars.sort.join('')
  end
end

def find_code
  known_numbers
  three
  six
  order_decode
  order_output
end

def score
  value = []
  @ordered_output.each do |x|
    value << @decode.index(x)
  end
  value.join('').to_i
end

def run
  total = []
  @input.each do |line|
    get_output(line)
    find_code
    total << score
  end
  p total
  p total.sum
end

run
