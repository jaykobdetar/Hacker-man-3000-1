module Random.Pcg.String exposing (rangeLengthString, string)

{-| String generators the tests used from kress95/random-pcg-extra (no longer available).
-}

import Random.Pcg as Random exposing (Generator)
import String


{-| A string of exactly `length` characters from the given generator.
-}
string : Int -> Generator Char -> Generator String
string length charGenerator =
    Random.map String.fromList (Random.list length charGenerator)


{-| A string with between `minLength` and `maxLength` characters (inclusive).
-}
rangeLengthString : Int -> Int -> Generator Char -> Generator String
rangeLengthString minLength maxLength charGenerator =
    Random.int minLength maxLength
        |> Random.andThen (\length -> string length charGenerator)
