input:"c" $ read0 `:input
test:"c" $ read0 `:test
test2:"c" $ read0 `:test2
/input:test2

/=========================================

p1:{sum "J" $ {(first x; last x)} each {x inter .Q.n} each x}

d:`one`two`three`four`five`six`seven`eight`nine!`one1one`two2two`three3three`four4four`five5five`six6six`seven7seven`eight8eight`nine9nine
r:{ssr[x;string y;string d[y]]}
p2:{p1 {x r/ key d} each x}

/=========================================
show 20#"="
show "part1"
show p1 input

show 20#"="
show "part2"
show p2 input

exit 0
