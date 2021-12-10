# https://adventofcode.com/2021/day/10
# Syntax Scoring, different kinds of brackets imbalance

require_relative 'common'

OPENING = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
PAIRS = OPENING.to_a.map(&:join)

class Day10 < AdventDay
  def corrupted_bracket(line)
    stack = []
    result = line.chars.each do |bracket|
      if OPENING[bracket]
        stack << bracket
      else
        last_opening = stack.pop
        break bracket if last_opening != OPENING.reverse[bracket]
      end
    end
    result.is_a?(String) ? result : false
  end
  
  def first_part
    points = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }
    init = Hash.new { |hash, key| hash[key] = 0 }
    counts = input.each_with_object(init) do |line, acc|
      corrupted = corrupted_bracket(line)
      acc[corrupted] += 1 if corrupted
    end
    counts.to_a.sum { |(k, v)| points[k] * v }
  end

  def second_part
    points = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }
    completions = input.each_with_object([]) do |line, list|
      next if corrupted_bracket(line)

      nil until line.gsub!(/\[\]|\(\)|\{\}|\<\>/, '').nil?
      list << line.reverse.chars.map { |ch| OPENING[ch] }.join
    end

    scores = completions.map { |str| str.chars.reduce(0) { |acc, elem| (acc * 5) + points[elem] } }
    scores.sort[scores.length / 2]
  end

  private

  def convert_data(data)
    super
  end
end

Day10.solve
