#/bin/bash

source .env
mkdir $1
curl -b session=$AOC_SESSION https://adventofcode.com/2023/day/$1/input > $1/input
curl -b session=$AOC_SESSION https://adventofcode.com/2023/day/1 | htmlq -t code > $1/test

cat > $1/foo.q <<- EOM
input:"c" $ read1 \`:input
test:"c" $ read1 \`:test

input:test

/=========================================


/=========================================

show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
EOM
