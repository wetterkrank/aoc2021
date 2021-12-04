# https://adventofcode.com/2021/day/1
# Count times when next depth measurement is larger than the previous

require_relative 'common'

class Day1 < AdventDay
  def first_part
    input.each_cons(2).count { |(previous, current)| current > previous }
  end

  def second_part
    input.each_cons(3).each_cons(2).count { |(prev, cur)| cur.sum > prev.sum }
  end

  private

  def convert_data(data)
    super.map(&:to_i)
  end
end

Day1.solve
