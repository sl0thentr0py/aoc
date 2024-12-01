i:"c" $ read0 `:input
t:"c" $ read0 `:test
/i:t
/=========================================
m:flip {"I"$"   "vs x} each i
p1:sum abs (asc m[1]) - (asc m[0])
d:count each group m[1]
p2:sum {x*d[x]} m[0]
/=========================================
show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
