# https://adventofcode.com/2021/day/21
# Dirac Dice -- yet another exponential growth task (see days 14 and 6)

require_relative 'common'

class Day21 < AdventDay
  def first_part
    pos = input.dup
    score = [0, 0]
    counter = 0
    player = 0
    rolls = []

    until score.any? { |s| s >= 1000 }
      counter += 1
      die = mod1(counter, 100)
      rolls << die
      next if rolls.count < 3

      pos[player] = mod1(pos[player] + rolls.sum, 10)
      score[player] += pos[player]
      
      player = 1 - player # flips between 0 and 1
      rolls = []
    end
    counter * score[player]
  end

  def second_part
    pos = input.dup
    freqs = [1, 2, 3].repeated_permutation(3).each_with_object(zero_hash) { |perm, obj| obj[perm.sum] += 1 }
    count_wins(0, 0, pos.first, pos.last, freqs)
  end

  private

  # To improve performance, we could memoize the winning combinations
  def count_wins(p1score, p2score, p1pos, p2pos, freqs)
    return [1, 0] if p1score >= 21
    return [0, 1] if p2score >= 21

    count1, count2 = [0, 0]

    freqs.each do |throw_sum, freq|
      new_pos = mod1(p1pos + throw_sum, 10)
      new_score = p1score + new_pos
      
      # Here, we rotate players in the recursive call so that the progress is balanced
      win2, win1 = count_wins(p2score, new_score, p2pos, new_pos, freqs)
      
      count1 += win1 * freq
      count2 += win2 * freq
    end
    [count1, count2]
  end

  def zero_hash
    Hash.new { |h, k| h[k] = 0 }
  end

  # Skipping 0 in the modulo op: mod1(10, 10) = 1 instead of 0
  # NOTE: Could hash be faster (for a limited number of inputs)?
  def mod1(num, top)
    ((num - 1) % top) + 1
  end

  def convert_data(data)
    super.map { _1.split(': ').last.to_i }
  end
end

Day21.solve
