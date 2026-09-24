module UI.FontAwesome.Helper exposing (..)

import Css exposing (Snippet, Style, before, fontFamilies, property)


type alias UnicodeTag =
    String


fontAwesome : Style
fontAwesome =
    fontFamilies [ "FontAwesome" ]


faIcon : UnicodeTag -> Style
faIcon icon =
    icon
        |> (\tag -> "\"\\" ++ tag ++ "\"")
        |> property "content"


fa : UnicodeTag -> Style
fa icon =
    icon
        |> faIcon
        |> List.singleton
        |> (::) fontAwesome
        |> before
