USING: grouping io.encodings.utf8 io.files kernel locals locals math
prettyprint sequences sets ;
IN: day6

"input/day6" utf8 file-contents { 4 14 }
[ [ clump [ all-unique? ] find drop ] keep + . ] with each
