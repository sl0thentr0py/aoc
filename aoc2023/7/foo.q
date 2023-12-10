i:"c" $ read0 `:input
t:"c" $ read0 `:test
/i:t
/=========================================
/replace chars to make ordering simpler later, J has a switch for part 2
r:{ssr[;"A";"Z"] ssr[;"K";"Y"] ssr[;"Q";"X"] ssr[;"J";$[0=y;"W";"1"]] ssr[;"T";"V"] x}
ty:{s:desc count each value group x;string $[(enlist 5)~s;7;(4 1)~s;6;(3 2)~s;5;(3 1 1)~s;4;(2 2 1)~s;3;(2 1 1 1)~s;2;1]}
/replace wildcards
w:{g:group x where not "J"=x;c:count each value g;r:(key g)[c?max c];$["JJJJJ"~x;x;ssr[x;"J";r]]}
/append score to beginning of string to order together, switch for part 2 to apply wildcards
m:{{x idesc x[;2]} {t:$[0=y;ty[x[0]];ty[w x[0]]];v:r[;y] t,x[0];x,enlist v}[;y] each " "vs' x}
p:{sum (reverse 1+til count x)*("J"$x[;1])}
p1:p m[i;0]
p2:p m[i;1]
/=========================================
show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
