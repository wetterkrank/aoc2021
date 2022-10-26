# advent-of-code-2021
My [Advent of Code 2021 🎄](https://adventofcode.com/2021) solutions.

## Notes to self

#### [Day 2: Dive!](https://adventofcode.com/2021/day/2)
- NB: Using `else` in a `case` statement can save some debugging time if the input gets messed up

#### [Day 3: Binary Diagnostic](https://adventofcode.com/2021/day/3)
- Sorting the input actually seems like a good idea. Should give it a try!

#### [Day 5: Hydrothermal Venture](https://adventofcode.com/2021/day/5)
- Used spaceship operator to turn a number into +1/0/-1
- Reused self-creating Hash from [last year](https://github.com/wetterkrank/aoc2020/blob/master/aoc17_1.rb)
- Looking into Wikipedia [Line article](https://en.wikipedia.org/wiki/Line_(geometry)) was helpful

#### [Day 6: Lanternfish](https://adventofcode.com/2021/day/6)
- Alternative approach: calculate the result for each input entry; use Hash to cache the result for the same age

#### [Day 7: The Treachery of Whales](https://adventofcode.com/2021/day/7)
- Used [arithmetic series formula](https://en.wikipedia.org/wiki/1_%2B_2_%2B_3_%2B_4_%2B_%E2%8B%AF)
- However, there's a better approach: the optimal position is the _median_ ([the value with the lowest absolute distance to the data](https://en.wikipedia.org/wiki/Median#Optimality_property)) in part 1, and the _mean_ in part 2

#### [Day 8: Seven Segment Search](https://adventofcode.com/2021/day/8)
- Presenting the digits as arrays of segments made it easy to derive digits from each other, but it was still manual work
- Would be interesting to make a universal solution (constaint solver?)

#### [Day 9: Smoke Basins](https://adventofcode.com/2021/day/9)
- Used what I guess is called flood fill algorithm
- Got tripped by Ruby's negative array indices (expected `nil`)
- And (more than once) by counting the previously visited cells in a recursive walkaround

#### [Day 11: Dumbo Octopus](https://adventofcode.com/2021/day/11)
- Remembered that using [x, y] for a hash containing grid elements is often more convenient than \[x]\[y]

#### [Day 15: Chiton](https://adventofcode.com/2021/day/15)
- That day I discovered [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm) 🧐
- However, the basic version wasn't any good for the 2nd part (250k cells). An optimization also described in the Wikipedia article (adding neighbour cells into the queue as we progress and removing them after the visit) helped.
- Haven't tried [A*](https://en.wikipedia.org/wiki/A*_search_algorithm), maybe for smth else!

#### [Day 16: Packet Decoder](https://adventofcode.com/2021/day/16)
- Used a class to simplify the position tracking
- TODO: rewrite using Ruby's `StringScanner` class, check out formal notation and theory on parsers

#### [Day 22: Reactor Reboot](https://adventofcode.com/2021/day/22)
- http://twocentstudios.com/2016/08/16/calculating-the-area-of-multiple-intersecting-rectangles-with-swift/
- For the recursive solution, the order in which we process cubes is important

## Running the code

- Run `bundle install` to install dependencies
- `ruby day-<number>.rb`
- The input data is stored in `/inputs` directory. If there's no input and the session cookie is provided through the SESSION env var — the framework will
fetch the input from the AoC website on the first run.

Thanks to [`@Aquaj`](https://github.com/Aquaj) for the handy Ruby framework!
