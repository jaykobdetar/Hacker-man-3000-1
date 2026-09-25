module UI.DynStyles.SimplePlan.Apps exposing (..)

import Apps.Browser.Resources as B
import Css exposing (..)
import Css.Elements exposing (typeSelector)
import Css.Namespace exposing (namespace)


simpleBrowser : Stylesheet
simpleBrowser =
    (stylesheet << namespace B.prefix)
        [ class B.Window
            [ children
                [ class B.Toolbar
                    [ display none ]
                , typeSelector "panel"
                    [ display none ]
                ]
            ]
        ]
