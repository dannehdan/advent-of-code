class Board
  attr_reader :board, :evaluation

  def initialize(numbers)
    @board = numbers
    @evaluation =
      (1..5).map { |i|
        (1..5).map { |j| 0 }
      }
  end

  def display_board
    @board.each do |x|
      print "#{x}\n"
    end
    print "\n"
    @evaluation.each do |y|
      print "#{y}\n"
    end
  end

  def score_rows(num)
    @board.each_with_index do |row_val, row_index|
      row_val.each_with_index do |col_val, col_index|
        if col_val == num
          @evaluation[row_index][col_index] = 1
        end
      end
    end
  end

  def evaluate_board
    evaluate_rows
    evaluate_columns
  end

  def evaluate_rows
    p "evaluating rows"
    @evaluation.each do |y|
      if y.all? { |element| element == 1 }
        return "winning row"
      end
    end
  end

  def evaluate_columns
    i = 0
    p "evaluating columns"
    while i < @evaluation[0].length
      tmp = []
      @evaluation.each do |y|
        if y[i] == 1
          tmp << 1
        end
      end
      if tmp.length == 5
        return "winning column"
        break
      end
      i += 1
    end
  end
end

class Game
  attr_reader :boards

  def initialize
    @nums = [14, 30, 18, 8, 3, 10, 77, 4, 48, 67, 28, 38, 63, 43, 62, 12, 68, 88, 54, 32, 17, 21, 83, 64, 97, 53, 24, 2, 60, 96, 86, 23, 20, 93, 65, 34, 45, 46, 42, 49, 71, 9, 61, 16, 31, 1, 29, 40, 59, 87, 95, 41, 39, 27, 6, 25, 19, 58, 80, 81, 50, 79, 73, 15, 70, 37, 92, 94, 7, 55, 85, 98, 5, 84, 99, 26, 66, 57, 82, 75, 22, 89, 74, 36, 11, 76, 56, 33, 13, 72, 35, 78, 47, 91, 51, 44, 69, 0, 90, 52]
    @winning_number = 0
    @winning_board = 0
    @winning_evaluation = 0
    @boards = []
  end

  def generate_boards
    input = File.read("./day-4/input.txt")
    new_thing = input.split("\n\n").map { |x| x.gsub("\n", " ").gsub("  ", " ") }
    new_thing.each do |x|
      arr = x.split(" ").map { |y| y.to_i }
      @boards << Board.new(arr.each_slice(5).to_a)
    end
  end

  def search
    @nums.each do |x|
      @boards.each do |calculate|
        @winning_number = x
        calculate.score_rows(x)
        if calculate.evaluate_rows == "winning row" || calculate.evaluate_columns == "winning column"
          p "Win after #{@nums.find_index(x) + 1} runs"
          @winning_board = calculate.board
          @winning_map = calculate.evaluation
          break
        end
      end
      if @winning_board != 0
        break
      end
    end
  end

  def score_board
    final_score = 0
    @winning_map.each_with_index do |row_val, row_index|
      row_val.each_with_index do |col_val, col_index|
        if col_val == 0
          final_score += @winning_board[row_index][col_index]
        end
      end
    end
    p final_score
    p @winning_number
    p @winning_board
    p @winning_map
    p final_score * @winning_number
  end
end

game = Game.new
game.generate_boards
game.search
# game.score_board
