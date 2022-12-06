USING: arrays combinators io.encodings.utf8 io.files kernel locals
math math.ranges math.parser prettyprint sequences splitting
strings ;
IN: day5

:: move-crates ( stack move -- stack )
    [let
     ! parse move
     move first :> crates-n
     move second 1 - :> from-idx
     move third 1 - :> to-idx

     ! transform the `from` stack
     from-idx stack nth :> from
     from crates-n tail :> from'
     from crates-n head
     reverse :> crates ! reverse, we take each crate 1 at a time

     ! transform the `to` stack
     crates to-idx stack nth append :> to

     ! mutate stack!!
     from' from-idx stack set-nth
     to to-idx stack set-nth

     ! return stack
     stack
    ] ;

! { { 78 90 } { 68 67 77 } { 80 } }
! { 1 2 1 }
! move-crates
! { 3 1 3 }
! move-crates
! { 2 2 1 }
! move-crates
! { 1 1 2 }
! move-crates
! [ >string ] map
! .

! part 1
"input/day5" utf8 file-lines
{ "" } split ! split on empty line
first2 swap ! split between moves & crates
but-last ! remove the last line of the crates with indices
[let
 :> stack-lines
 0 stack-lines length [a,b] [ 4 * 1 + ] map ! 1 5 9 13 ...
 [ [let
    :> idx
    stack-lines
    [ idx swap nth ] map ! get the index from each line
    [ 32 = not ] filter ] ! filter out empty places on the stack
 ] map
]
swap ! moves to the front
! map each line to { crates from to }
[ " " split [ string>number ] map [ ] filter ] map
swap ! stacks to the front
[ move-crates ] reduce
[ first ] map
>string
.
