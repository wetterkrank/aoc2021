# https://adventofcode.com/2021/day/3

require_relative 'common'

class Day3 < AdventDay
  def first_part
    # freqs = ::Array.new(12, 0)
    # input.each { |line| line.chars.each.with_index { |char, i| freqs[i] += char.to_i } }
    # epsilon = freqs
    #           .map { |ones| ones > input.length - ones ? '1' : '0' }
    #           .join.to_i(2)
    # gamma = (~epsilon) & ((1 << freqs.length) - 1)
    # epsilon * gamma
  end

  def second_part
    rows = input.length
    columns = input.first.length

    find_mode = lambda do |selection, index|
      ones = selection.sum { |row| input[row][index] }
      ones >= selection.length - ones ? 1 : 0
    end

    select_modes = lambda do |reverse: false|
      selection = (0..rows - 1).to_a
      columns.times do |i|
        mode = find_mode.call(selection, i) ^ (reverse ? 1 : 0)
        selection = selection.filter { |row| input[row][i] == mode }
        return input[selection.first] if selection.one?
      end
    end

    modes = select_modes.call(input).join.to_i(2)
    antimodes = select_modes.call(input, reverse: true).join.to_i(2)
    modes * antimodes
  end

  private

  def convert_data(data)
    super.map { |line| line.chars.map(&:to_i) }
  end
end

Day3.solve
