input:("SSS";" ")0:`:../files/07.input

/=========================================

cd:{$[null y;x;`..=y;-1 _ x;x,y]}
prefixes:{n:-1 _ reverse til count x;#[;x] each n}

sizes:flip `path`size!((0#`) cd\ input[2];"I"$string input[0])

/group to directories
sizes:0! select sum size by path from sizes

/need to process in desc depth to ensure convergence
sizes:`depths xdesc update depths:count'[path] from sizes

/backfill prefix sizes in place, ignore root
{update size+x`size from `sizes where (sizes`path)in(prefixes x`path)} each -1 _ sizes

p1:exec sum size from sizes where size < 100000
p2:exec min size from sizes where (sizes`size) > (((last sizes)`size) - 40000000)

/=========================================

show 20#"="
show "part1"
show p1

show 20#"="
show "part2"
show p2

exit 0
