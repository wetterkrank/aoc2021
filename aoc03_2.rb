# https://adventofcode.com/2021/day/3

# Let's make this a 2d array
data = ::File.open('aoc03_input.txt').readlines.map { |line| line.chomp.chars.map(&:to_i) }

# A typical way to find mode is to use a Hash
# Since we only have 0s and 1s, we can simply #sum and compare
def find_mode(data, selection, index)
  ones = selection.sum { |row| data[row][index] }
  ones >= selection.length - ones ? 1 : 0
end

# Iterate through data columns
# Narrow down the selection based on column mode until one row left
def select_modes(data, reverse: false)
  selection = (0..data.length - 1).to_a
  data.first.length.times do |i|
    mode = find_mode(data, selection, i) ^ (reverse ? 1 : 0)
    selection = selection.filter { |row| data[row][i] == mode }
    return data[selection.first] if selection.one?
  end
end

modes = select_modes(data).join.to_i(2)
antimodes = select_modes(data, reverse: true).join.to_i(2)

p modes
p antimodes
p modes * antimodes
