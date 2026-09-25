module Core.Style exposing (..)

import Core.Resources exposing (appId, prefix)
import Css exposing (..)
import Css.Elements exposing (body, footer, header, li, main_, nav, typeSelector)
import Css.Namespace exposing (namespace)
import Utils.Css exposing (unselectable)


css : Stylesheet
css =
    (stylesheet << namespace prefix)
        [ body
            [ displayFlex
            , minWidth (vw 100)
            , minHeight (vh 100)
            , maxWidth (vw 100)
            , maxHeight (vh 100)
            , overflow hidden
            , margin (px 0)
            , cursor default
            , unselectable
            ]
        , id appId
            [ width (pct 100)
            , minHeight (pct 100)
            ]
        ]
