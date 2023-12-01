input:read0 `:../files/05.input

/=========================================

stacks:{(count raze x)$x} / pad till max possible row length
        trim flip         / stack tops in the beginning
        ({x where (((til count x)-1)mod 4)=0}')
        -1 _ (input?"") # input

strip:{ssr [;"to ";""] ssr [;"from ";""] ssr[;"move ";""] x}
instructions:flip `num`from`to!("III";" ") 0:(strip') (1+input?"";count input) sublist input

reverse_n:{(reverse y # x) , y _ x} / reverse first n rows

move1:{[s;i]
      @[;i[`to]-1;(neg i[`num]) rotate]         / rotate them back, voila!
      flip reverse                              / put it back
      reverse_n[;i[`num]]                       / reverse those num rows
      @[;til i[`num];(i[`from]-i[`to]) rotate]  / move to the to stack
      reverse flip                              / transpose and move that shit to the top
      @[;i[`from]-1;i[`num] rotate] s}          / rotate num elements to end of from row

move2:{[s;i]
      @[;i[`to]-1;(neg i[`num]) rotate]         / rotate them back, voila!
      flip reverse                              / put it back
      @[;til i[`num];(i[`from]-i[`to]) rotate]  / move to the to stack
      reverse flip                              / transpose and move that shit to the top
      @[;i[`from]-1;i[`num] rotate] s}          / rotate num elements to end of from row

p1: (first') stacks move1/ instructions
p2: (first') stacks move2/ instructions

/=========================================

show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
