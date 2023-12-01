input:"c" $ read1 `:../files/01.input

/=========================================

calories:"J" $ (vs["\n"]') "\n\n" vs input
p1:max (sum') calories
p2:sum 3 # desc (sum') calories

/=========================================

show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
