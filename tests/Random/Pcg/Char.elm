module Random.Pcg.Char exposing (english)

{-| Character generator the tests used from kress95/random-pcg-extra (no longer available).
-}

import Char
import Random.Pcg as Random exposing (Generator)


{-| A random English letter, upper or lower case.
-}
english : Generator Char
english =
    Random.choices
        [ Random.map Char.fromCode (Random.int 65 90)
        , Random.map Char.fromCode (Random.int 97 122)
        ]
