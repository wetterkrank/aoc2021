# https://adventofcode.com/2021/day/4
# Bingo game with a giant squid

require_relative 'common'

class Day4 < AdventDay
  def bingo?(board, draw)
    (board + board.transpose).any? { |line| (draw & line).size == 5 }
  end

  def first_part
    draw = input[:draw].first(4)
    input[:draw].drop(4).each do |number|
      draw << number
      winner = input[:boards].find { |board| bingo?(board, draw) }
      return number * (winner.flatten - draw).sum if winner
    end
    # nil
  end

  def second_part
    boards = input[:boards] # just for convenience
    draw = input[:draw].first(4)
    input[:draw].drop(4).each do |number|
      draw << number
      winners, boards = boards.partition { |board| bingo?(board, draw) }
      return number * (winners.last.flatten - draw).sum if boards.count.zero?
    end
    # nil
  end

  private

  def convert_data(data)
    data = data.split("\n\n")
    {
      draw: data.first.split(',').map(&:to_i),
      boards: data.drop(1).map { |block| block.split("\n").map { |row| row.split.map(&:to_i) } }
    }
  end
end

Day4.solve
