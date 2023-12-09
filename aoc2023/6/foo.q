i:"c" $ read0 `:input
t:"c" $ read0 `:test
/i:t
/=========================================
m:flip {{"J"$" "vs({" "sv"  "vs x}/) x} last trim":"vs x} each i
m2:"J"${{({""sv" "vs x}/) x} last trim":"vs x} each i
c:{i:ceiling x;$[i=x;i+1;i]}
f:{i:floor x;$[i=x;i-1;i]}
q:{d:sqrt (x*x)-(4*y);1+(f 0.5*(x+d))-(c 0.5*(x-d))}
p1:(*/) q .' m
p2:q . m2
/=========================================
show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
