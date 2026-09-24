module Random.Pcg.Extra exposing (andMap, rangeLengthList)

{-| The two helpers the tests used from kress95/random-pcg-extra, a package that is no
longer available.
-}

import Random.Pcg as Random exposing (Generator)


{-| Applies a generator of values to a generator of functions (for building records).
-}
andMap : Generator a -> Generator (a -> b) -> Generator b
andMap =
    Random.map2 (|>)


{-| A list whose length is between `minLength` and `maxLength` (inclusive).
-}
rangeLengthList : Int -> Int -> Generator a -> Generator (List a)
rangeLengthList minLength maxLength generator =
    Random.int minLength maxLength
        |> Random.andThen (\length -> Random.list length generator)
