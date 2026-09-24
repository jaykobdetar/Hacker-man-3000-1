module Apps.ConnManager.Style exposing (..)

import Apps.ConnManager.Resources exposing (Classes(..), prefix)
import Css exposing (..)
import Css.Colors as Colors
import Css.Namespace exposing (namespace)
import UI.Icons as Icons


ico : Style
ico =
    before
        [ Icons.fontFamily
        , textAlign center
        ]


css : Stylesheet
css =
    (stylesheet << namespace prefix)
        [ class IcoUp
            [ ico
            , before [ Icons.upload ]
            ]
        , class IcoDown
            [ ico
            , before [ Icons.download ]
            ]
        , class GroupedTunnel
            [ borderBottom3 (px 1) solid Colors.black
            ]
        ]
