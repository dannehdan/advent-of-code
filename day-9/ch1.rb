@input = %w[
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
]
# @input = File.readlines('./day-9/input.txt').map(&:chomp)

def set_input
  p @input
  @arr = []
  @input.each do |x|
    @arr << x.split('').map(&:to_i)
  end
end

def find_min
  @min = []
  @arr.each_with_index do |row_val, row_index|
    row_val.each_with_index do |col_val, col_index|
      @min << col_val if check_neighbours(col_val, row_index, col_index)
    end
  end
end

def check_neighbours(col_val, row_index, col_index)
  l = (check_left(row_index, col_index) > col_val) unless col_index == 0
  u = (check_up(row_index, col_index) > col_val) unless row_index == 0
  r = (check_right(row_index, col_index) > col_val) unless col_index == (@arr[0].length - 1)
  d = (check_down(row_index, col_index) > col_val) unless row_index == (@arr.length - 1)
  (l || l.nil?) && (u || u.nil?) && (r || r.nil?) && (d || d.nil?)
end

def check_up(row_index, col_index)
  @arr[row_index - 1][col_index]
end

def check_down(row_index, col_index)
  @arr[row_index + 1][col_index]
end

def check_left(row_index, col_index)
  @arr[row_index][col_index - 1]
end

def check_right(row_index, col_index)
  @arr[row_index][col_index + 1]
end

def score
  score = 0
  @min.map { |x| score += (x + 1) }
  p score
end

def run
  set_input
  find_min
  score
end

run
