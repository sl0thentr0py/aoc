i:"c" $ read0 `:input
t:"c" $ read0 `:test
/i:t
/=========================================
p:{count (inter/) {"J"$" "vs(" "sv"  "vs)/[x]} each x} each {trim each "|" vs x} each {trim last ":" vs x} each i
p1:sum {$[x>0;2 xexp (x-1);0]} each p
p2:sum {n:x[y];@[x;1+y+til z;{y+x}[;n]]}/[(count p)#1;til count p;p]
/=========================================
show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
