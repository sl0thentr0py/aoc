i:"c" $ read0 `:input
t:"c" $ read0 `:test
/i:t
/=========================================
m:"I"$ vs[" ";] each i
s:{all within [;(1 3)] 1_ prior[-;] x}
safe:{(s x)|(s reverse x)}
p1:sum safe each m
subsets:{i:{(til y) except x}[;count x] each til count x;x[i]} /n-1-subset indices of x
p2:sum {any safe each subsets x} each m
/=========================================
show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
