# https://adventofcode.com/2021/day/3
# Binary diagnostics: narrowing down the list of values according to the mode of the most significant bit

require_relative 'common'

class Day3 < AdventDay
  def first_part
    freqs = ::Array.new(input.first.length, 0)
    input.each { |line| line.each.with_index { |num, i| freqs[i] += num } }
    epsilon = freqs.map { |ones| ones > input.length - ones ? '1' : '0' }.join.to_i(2)
    gamma = (~epsilon) & ((1 << freqs.length) - 1)
    epsilon * gamma
  end

  def second_part
    rows = input.length
    columns = input.first.length

    find_mode = lambda do |input, selection, index|
      ones = selection.sum { |row| input[row][index] }
      ones >= selection.length - ones ? 1 : 0
    end

    select_modes = lambda do |input, reverse: false|
      selection = (0..rows - 1).to_a
      columns.times do |i|
        mode = find_mode.call(input, selection, i) ^ (reverse ? 1 : 0)
        selection = selection.filter { |row| input[row][i] == mode }
        return input[selection.first] if selection.one?
      end
    end

    majority = select_modes.call(input).join.to_i(2)
    minority = select_modes.call(input, reverse: true).join.to_i(2)
    majority * minority
  end

  private

  def convert_data(data)
    super.map { |line| line.chars.map(&:to_i) }
  end
end

Day3.solve
