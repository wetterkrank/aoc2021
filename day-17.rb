# https://adventofcode.com/2021/day/17
# Trick Shot

require_relative 'common'

class Day17 < AdventDay
  def sim_x(vel, range, infinity)
    v = vel
    pos = 0
    ts = []
    (1..).each do |t|
      pos += v
      v -= 1
      ts << t if range.include?(pos)
      ts << (t + 1..infinity).to_a if v.zero?
      break if pos > range.last || v.zero?
    end
    ts.flatten
  end

  def sim_y(vel, range)
    v = vel
    pos = 0
    ts = []
    (1..).each do |t|
      pos += v
      v -= 1
      ts << t if range.include?(pos)
      break if pos < range.first
    end
    ts
  end

  # we're expecting the whole target range < 0 here
  def find_vy(range)
    vy_min = range.first
    vy_max = -range.first - 1 # vy will be -(vy0 + 1) when we reach 0 again
    (vy_min..vy_max).each_with_object(empty_hash) do |vy, obj|
      ts = sim_y(vy, range)
      obj[vy] = ts unless ts.empty?
    end
  end

  def find_vx(range, infinity)
    vx_min = ((-1 + Math.sqrt(1 + (4 * 2 * range.first))) / 2).ceil # if vx < vx_min, we won't make it to x0
    vx_max = range.last # if vx > vx_max, we'll overshoot the target on t=1
    (vx_min..vx_max).each_with_object(empty_hash) do |vx, obj|
      ts = sim_x(vx, range, infinity)
      obj[vx] = ts
    end
  end

  def first_part
    _x0, _x1, y0, y1 = input
    vy = find_vy((y0..y1)).keys.max
    ((vy**2) + vy) / 2 # s = t * (v0 + v) / 2
  end

  def second_part
    x0, x1, y0, y1 = input
    vy_steps = find_vy((y0..y1)) # velocity -> t values when the probe is within target
    infinity = vy_steps.values.flatten.max
    vy_steps = invert_map(vy_steps) # t value -> velocities than put probe within target on this t
    vx_steps = invert_map(find_vx((x0..x1), infinity)) # same for vx
    combos = []
    vy_steps.each do |step, vy_options|
      vx_options = vx_steps[step]
      step_combos = vx_options.product(vy_options)
      puts "#{step} -> #{vx_options.product(vy_options)}"
      combos << step_combos
    end
    combos.flatten(1).uniq.count
  end

  private

  def invert_map(hash)
    hash.each_with_object({}) do |(key, value), result|
      value.each { |v| (result[v] ||= []) << key }
    end
  end

  def empty_hash
    Hash.new { |h, k| h[k] = [] }
  end

  def convert_data(data)
    /^.*x=(?<x0>.*)\.\.(?<x1>.*), y=(?<y0>.*)\.\.(?<y1>.*)$/.match(super.first)[(1..4)].map(&:to_i)
  end
end

Day17.solve
