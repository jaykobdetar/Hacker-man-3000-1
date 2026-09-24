module UI.DynStyles.Highlight.OS exposing (..)

import Apps.Shared as Apps
import Css exposing (..)
import Css.Namespace exposing (namespace)
import Game.Meta.Types.Context exposing (Context)
import Game.Meta.Types.Desktop.Apps as DesktopApp exposing (DesktopApp)
import OS.Header.Resources as Header
import OS.WindowManager.Dock.Resources as Dock
import OS.WindowManager.Resources as WM
import Utils.Css as Css exposing (nest, withAttribute)
import Utils.Html.Attributes exposing (activeContextValue, appAttrTag)


highlightDockIcon : DesktopApp -> Stylesheet
highlightDockIcon app =
    (stylesheet << namespace Dock.prefix)
        [ class Dock.ItemIco
            [ withAttribute (Css.EQ Dock.appIconAttrTag (Apps.icon app))
                [ borderRadius (px 0) |> important
                , backgroundImage none |> important
                , backgroundColor (hex "F00")
                ]
            ]
        ]


highlightHeaderContextToggler : Context -> Stylesheet
highlightHeaderContextToggler context =
    (stylesheet << namespace Header.prefix)
        [ class Header.Context
            [ withAttribute (Css.NOT (Css.BOOL Header.headerContextActiveAttrTag))
                [ backgroundColor (hex "F00") ]
            ]
        ]


highlightWindow : DesktopApp -> Context -> Stylesheet
highlightWindow app context =
    (stylesheet << namespace WM.prefix)
        [ class WM.Window
            [ nest
                [ withAttribute (Css.EQ appAttrTag (Apps.name app))
                , context
                    |> activeContextValue
                    |> Css.EQ "context"
                    |> withAttribute
                ]
                [ backgroundColor (hex "F00") ]
            ]
        ]
