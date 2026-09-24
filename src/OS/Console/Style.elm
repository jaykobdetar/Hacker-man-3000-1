module OS.Console.Style exposing (..)

import Css exposing (..)
import Css.Colors
import Css.Elements exposing (div, h6, li, typeSelector, ul)
import Css.Namespace exposing (namespace)
import OS.Console.Resources exposing (..)
import UI.Colors as Colors
import UI.Common exposing (flexContainerHorz, flexContainerVert, globalShadow)
import UI.Icons as Icons
import UI.Style exposing (clickableBox)
import Utils.Css as Css exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace prefix)
        [ class LogConsole
            [ width (pct 100)
            , marginTop (px 41)
            , flexContainerVert
            , position absolute
            , zIndex (int 0)
            , backgroundColor (rgba 0 0 0 0.5)
            , color (hex "00FF00")
            , fontFamily monospace
            , fontFamilies [ "Monospace" ]
            , fontSize (px 8)
            , children
                [ div
                    [ children
                        [ consoleHeader
                        ]
                    ]
                ]
            ]
        ]


consoleHeader : Snippet
consoleHeader =
    class LogConsoleHeader
        [ justifyContent spaceBetween
        , children
            [ class BFRequest
                [ color Css.Colors.blue ]
            , class BFReceive
                [ color Css.Colors.yellow ]
            , class BFJoin
                [ color Css.Colors.lime ]
            , class BFJoinAccount
                [ color Css.Colors.green ]
            , class BFJoinServer
                [ color Css.Colors.maroon ]
            , class BFOther
                [ color Css.Colors.gray ]
            , class BFNone
                [ color Css.Colors.silver ]
            , class BFEvent
                [ color Css.Colors.orange ]
            , class BFError
                [ color Css.Colors.red ]
            ]
        ]
