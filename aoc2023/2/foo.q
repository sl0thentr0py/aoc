input:"c" $ read0 `:input
test:"c" $ read0 `:test

/input:test

/=========================================
p:{v:"J"$x[0];$[x[1] like "red";(v;0;0);x[1] like "green";(0;v;0);x[1] like "blue";(0;0;v);(0;0;0)]}
g:{{sum p each {" " vs trim x} each "," vs x} each ";" vs trim last ":" vs x} each input

p1:sum 1 + where {all {all x<=(12 13 14)} each x} each g
p2:sum (*/) each max each g
/=========================================

show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
