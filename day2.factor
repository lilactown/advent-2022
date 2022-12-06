USING: combinators io.encodings.utf8 io.files kernel math prettyprint
sequences splitting ;
IN: day2
SYMBOLS: rock paper scissor draw win lose ;

: judge-round ( round -- score )
    { { { rock rock } [ 4 ] }
      { { paper rock } [ 1 ] }
      { { scissor rock } [ 7 ] }

      { { rock paper } [ 8 ] }
      { { paper paper } [ 5 ] }
      { { scissor paper } [ 2 ] }

      { { rock scissor } [ 3 ] }
      { { paper scissor } [ 9 ] }
      { { scissor scissor } [ 6 ] }
    } case ;

"input/day2" utf8 file-lines ! read file into a sequence of lines
dup ! duplicate for part 2

! Part 1
[ " " split ! split the line by space
  [ { { "A" [ rock ] }
      { "B" [ paper ] }
      { "C" [ scissor ] }
      { "X" [ rock ] }
      { "Y" [ paper ] }
      { "Z" [ scissor ] } }
    case ] map ! map each character to corresponding choice
  judge-round ! compute the score
] map ! map the above operations each line
0 [ + ] reduce ! compute the sum of all games
. ! print the result

! Part 2
[ { { "A X" [ { rock scissor } ] }
    { "A Y" [ { rock rock } ] }
    { "A Z" [ { rock paper } ] }
    { "B X" [ { paper rock } ] }
    { "B Y" [ { paper paper } ] }
    { "B Z" [ { paper scissor } ] }
    { "C X" [ { scissor paper } ] }
    { "C Y" [ { scissor scissor } ] }
    { "C Z" [ { scissor rock } ] }
  } case ! convert each line to the right outcome
  judge-round ! compute the score
] map ! for each line
0 [ + ] reduce ! sum scores
. ! print result
