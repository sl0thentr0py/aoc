input:"c" $ read0 `:../files/04.input

/=========================================

bitfield:{@[100#0b;(x-1)+til(1+y-x);not]}
ranges:(({bitfield . x}')') "J" $ ({(vs["-"]') x}') (vs[","]') input
p1:sum (.[{a:x&y;(all a=x)|(all a=y)}]') ranges
p2:sum (.[{any x&y}]') ranges

/=========================================

show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
