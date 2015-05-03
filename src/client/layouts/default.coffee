Layout = require '../layout.coffee'


module.exports = new Layout [
  [
    ( [ i, 0 ] for i in [1..12] )...
    ( [ i, 1 ] for i in [3..10] )...
    ( [ i, 2 ] for i in [2..11] )...
    ( [ i, 3 ] for i in [1..12] )...
    [0, 3.5], [13, 3.5], [14, 3.5]
    ( [ i, 4 ] for i in [1..12] )...
    ( [ i, 5 ] for i in [2..11] )...
    ( [ i, 6 ] for i in [3..10] )...
    ( [ i, 7 ] for i in [1..12] )...
  ]
  [
    ( [ i, 1 ] for i in [4..9] )...
    ( [ i, 2 ] for i in [4..9] )...
    ( [ i, 3 ] for i in [4..9] )...
    ( [ i, 4 ] for i in [4..9] )...
    ( [ i, 5 ] for i in [4..9] )...
    ( [ i, 6 ] for i in [4..9] )...
  ]
  [
    ( [ i, 2 ] for i in [5..8] )...
    ( [ i, 3 ] for i in [5..8] )...
    ( [ i, 4 ] for i in [5..8] )...
    ( [ i, 5 ] for i in [5..8] )...
  ]
  [
    ( [ i, 3 ] for i in [6..7] )...
    ( [ i, 4 ] for i in [6..7] )...
  ]
  [
    [6.5, 3.5]
  ]
]
