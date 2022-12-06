IN: day1
USING: io io.encodings.utf8 io.files kernel math math.order
math.parser prettyprint sequences sorting splitting ;

"input/day1" utf8 file-lines ! read file into a sequence of lines
[ string>number ] map ! convert each line into a number
[ not ] split-when ! split on empty lines (converted to `f` by `string>number`)
[ 0 [ + ] reduce ] map ! sum each subsequence of numbers

! Part 1
[ 0 [ max ] reduce ! find max
  . ]

! Part 2
[ [ >=< ] sort ! sort from greatest to least
  3 head ! take the first three elements
  0 [ + ] reduce ! sum them
  . ]
bi
