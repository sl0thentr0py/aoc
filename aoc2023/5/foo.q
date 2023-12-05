i:"c" $ read1 `:input
t:"c" $ read1 `:test
/i:t
/=========================================
i:"\n\n" vs i,"\n"
s:"J"$" "vs trim last ":"vs i[0]
m:{{"J"$" "vs x} each 1_"\n"vs trim last ":"vs x} each -1_1_i
f:{n:(count y)#x;i:first where (n>=y[;1])&(n<(y[;1]+y[;2]));$[null i;x;x+y[i;0]-y[i;1]]}
p1:min {f/[x;m]} each s
/brute force no workey
p2:min {f/[x;m]} each raze {x[0] + til x[1]} each (2 0N)#s
/=========================================
show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
