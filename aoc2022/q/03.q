input:read0 `:../files/03.input

/=========================================

sacks:{(x-96) mod 58} `int $ input
p1:sum ({first (inter/) 2 0N#x}') sacks
p2:sum ({first (inter/) x}') 0N 3#sacks

/=========================================

show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
