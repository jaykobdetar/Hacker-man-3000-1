module Apps.Email.Style exposing (..)

import Apps.Email.Resources exposing (Classes(..), prefix)
import Css exposing (..)
import Css.Elements exposing (div, li, span, ul)
import Css.Namespace exposing (namespace)
import UI.Colors as Colors
import UI.Common exposing (..)
import Utils.Css exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace prefix)
        [ class Contacts
            [ flex (int 0)
            , overflowY auto
            , overflowX hidden
            , listStyle none
            , padding (px 0)
            , children
                [ li
                    [ padding2 (px 22) (px 8)
                    , children
                        [ class Avatar
                            [ width (px 48)
                            , height (px 48)
                            , borderRadius (pct 100)
                            ]
                        ]
                    ]
                ]
            ]
        ]
