i:"c" $ read0 `:input
t:"c" $ read0 `:test
/i:t
/=========================================
fill:{x|(1 rotate x)|(-1 rotate x)}
mask:{flip fill each flip fill each x}
mask1: raze mask not i in .Q.n,"."
groups:{flip (where -1=(-1 rotate x)-x;where -1=(1 rotate x)-x)} raze i in .Q.n
p1:sum {r:x[0]+til(1+x[1]-x[0]);$[any mask1[r];"I"$(raze i)[r];0]} each groups

mask2:raze mask (count i;0N)#{g:(+\) x;@[g;where not x;:;0]} raze i="*"
g2:{r:x[0]+til(1+x[1]-x[0]);$[any mask2[r];(max mask2[r];"I"$(raze i)[r]);(0;0)]} each groups
p2:sum {l:g2[x;1];$[(count l)>1;(*/)l;0]} each value group g2[;0]
/=========================================
show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
