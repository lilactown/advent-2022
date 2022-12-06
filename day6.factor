USING: grouping io.encodings.utf8 io.files kernel locals locals math
prettyprint sequences sets ;
IN: day6

:: solve ( str n -- m )
    str n clump ! all groupings of n many letters
    [ all-unique? ] find ! first elt whose set elements are unique
    drop ! ^ pushes the elt and index, drop the elt
    n + ; ! add n to it to get the starting index

"input/day6" utf8 file-contents

! part 1
[ 4 solve . ]
! part 2
[ 14 solve . ] bi
