# advent-of-code-2021
[Advent of Code 2021 🎄](https://adventofcode.com/year/2021) solutions. Thanks to [`@Aquaj`](https://github.com/Aquaj) for the handy Ruby framework.

## Notes to self

#### [Day 2: Dive!](https://adventofcode.com/2021/day/2)
Use `else` in the `case` statement, it can save some debugging time if the input gets messed up.

#### [Day 3: Binary Diagnostic](https://adventofcode.com/2021/day/3)
Sorting the input actually seems like a good idea. Should give it a try!

#### [Day 5: Hydrothermal Venture](https://adventofcode.com/2021/day/5)
- Used spaceship operator to turn a number into +1/0/-1
- Reused self-creating Hash from [last year](https://github.com/wetterkrank/aoc2020/blob/master/aoc17_1.rb)
- Looking at Wikipedia [Line article](https://en.wikipedia.org/wiki/Line_(geometry)) was helpful

## Running the code

- Run `bundle install` to install dependencies
- `ruby day-<number>.rb`
- The input data is stored in `/inputs` directory. If there's no input and the session cookie is provided through the SESSION env var — the framework will
fetch the input from the AoC website on the first run.
