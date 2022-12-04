USING: io.encodings.utf8 io.files kernel math.parser math.ranges
prettyprint sequences sets splitting ;
IN: day4

"input/day4" utf8 file-lines ! read file into a sequence of lines
[ "," split ! split the line by ","
  [ "-" split ! split the range string by "-"
    [ string>number ] map ! each side of the range, convert to number
    first2 [a,b] ! convert numbers to range type
  ] map ! for each elf in the pair
] map ! for each line
dup ! duplicate for part 2...

[ [ first2 subseq? ] ! see if first range is contained in second
  [ reverse first2 subseq? ] ! see if second range is contained in first
  bi ! apply 2 quotations to the line, putting their values on the stack
  or ! return true if either is true, false if neither
] count ! count the results that pass
. ! print the result

[ first2 intersects? ] count .
