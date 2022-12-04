USING: io.encodings.utf8 io.files kernel prettyprint sequences
splitting math.ranges math.parser ;
IN: day4

"input/day4" utf8 file-lines ! read file into a sequence of lines
[ "," split ! split the line by ","
  [ "-" split ! split the range string by "-"
    [ string>number ] map ! each side of the range, convert to number
    first2 [a,b] ! convert numbers to range type
  ] map ! for each elf in the pair
  dup ! create a duplicate..
  first2 subseq? ! see if first range is contained in second
  swap ! move copy of ranges to the front
  reverse first2 subseq? ! see if second range is contained in first
  or ! return true if either is true, false if neither
] map ! for each line
[ ] count
. ! print the result
