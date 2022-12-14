USING: arrays assocs combinators grouping io.encodings.utf8 io.files
kernel math math.ranges namespaces prettyprint quotations sequences
sets splitting ;
IN: day3

! priorities table
SYMBOL: priorities
"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
1 52 [a,b] zip ! create array of { a 1 } { b 2 } ...
priorities
set-global ! set this value as a global var `priorities`


"input/day3" utf8 file-lines ! read file into a sequence of lines

! part 1
[ [ dup length 2 / cut ! split at the midpoint of the string
    intersect ! find the one letter in common between the two halves
    first priorities get-global at ! convert letter codepoint to priority
  ] map
  0 [ + ] reduce ! add up all priorities
  . ]

! part 2
[ 3 group ! group the lines into clumps of 3
  [ first3 ! put the 3 strings on the stack
    intersect intersect ! find their intesection
    first priorities get-global at ! map the remaining letter to its priority
  ] map
  0 [ + ] reduce ! add up the priorities
  . ]
bi
