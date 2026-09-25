module UI.Elements.ProgressBar exposing (progressBar)

import Css exposing (Style, asPairs, fontSize, int, lineHeight, minHeight, pct, px, width)
import Html exposing (Attribute, Html, node, text)
import Html.Attributes as Html exposing (style)
import Html.CssHelpers exposing (withNamespace)


{ id, class, classList } =
    withNamespace "ui"


styles : List Style -> Attribute msg
styles =
    asPairs >> Html.style


progressBar : Float -> String -> Float -> Html msg
progressBar percent floatText height =
    node "progressBar"
        [ styles [ minHeight (px height) ] ]
        [ node "fill"
            [ styles
                [ width
                    (pct
                        (percent * 100)
                    )
                , lineHeight (int 1)
                , fontSize (px height)
                ]
            ]
            []
        , node "label" [] [ text floatText ]
        ]
