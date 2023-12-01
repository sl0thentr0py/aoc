input:"c" $ read1 `:../files/06.input

/=========================================

win:{(y-1)_{1_x,y}\[y#0;x]}
solve:{y+?[(count') (distinct') win[input;y];y]}
p1: solve[input;4]
p2: solve[input;14]

/=========================================

show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
