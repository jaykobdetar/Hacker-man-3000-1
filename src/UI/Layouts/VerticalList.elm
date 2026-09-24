module UI.Layouts.VerticalList exposing (..)

import Html exposing (Attribute, Html, node)


verticalList : List (Attribute msg) -> List (Html msg) -> Html msg
verticalList attr entries =
    node "verticallist" attr entries
