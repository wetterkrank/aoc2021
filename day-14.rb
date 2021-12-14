# https://adventofcode.com/2021/day/13
# Extended Polymerization

require_relative 'common'

class Day14 < AdventDay
  def first_part
    solver(*input, 10)
  end
  
  def second_part
    solver(*input, 40)
  end

  def solver(str, rules, levels)
    pairs_zero = str.chars.each_cons(2).map(&:join)
    pair_freqs = { 0 => count_frequencies(pairs_zero) }
    char_freqs = count_frequencies(str.chars)
    levels.times do |level|
      pair_freqs[level].each_entry do |pair, freq|
        char = rules[pair]
        char_freqs[char] = char_freqs[char].nil? ? freq : char_freqs[char] += freq
        split_pair = [pair[0] + rules[pair], rules[pair] + pair[1]]
        pair_freqs[level + 1] = count_frequencies(split_pair, freq, pair_freqs[level + 1])
      end
    end
    char_freqs.values.max - char_freqs.values.min
  end

  private

  def count_frequencies(array, multiplier = 1, freqs = nil)
    freqs = {} if freqs.nil?
    array.each_with_object(freqs) do |elem, obj|
      obj[elem] = obj[elem].nil? ? multiplier : obj[elem] += multiplier
    end
  end

  def convert_data(data)
    [
      super.first, 
      super[2..].map { |line| line.split(' -> ') }.to_h
    ]
  end
end

Day14.solve
