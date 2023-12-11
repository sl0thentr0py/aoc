i:"c" $ read1 `:input
t:"c" $ read1 `:test3
/i:t
/=========================================
m:first "\n\n"vs i
g:(!) . flip {c:vs[", "] ssr[;"[()]";""] x[1];(x[0];c)} each vs[" = ";] each -1_"\n"vs last "\n\n"vs i

inner:{z[x][$["L"=y;0;1]]}[;;g]
/return tuples of (last element of run;steps so far;continue looping)
outer:{l:x[0] inner\ z;f:first where (y')l;(last l;x[1]+$[null f;count l;1+f];null f)}[;;m]
/this is a while loop ^^
f:{{x[1]} {x[2]} outer[;y]/ (x;0;1b)}
p1:f["AAA";"ZZZ"~]

s2:(key g) where {"A"=x[2]} each key g
gcd:{$[0=y;x;.z.s[y;x mod y]]}
lcm:{(x*y) div gcd[x;y]}
p2:(lcm/) f[;{"Z"=x[2]}] each s2
/=========================================
show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

/exit 0
