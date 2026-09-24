module Apps.CtrlPanel.Style exposing (..)

import Apps.CtrlPanel.Resources exposing (..)
import Css exposing (..)
import Css.Namespace exposing (namespace)


css : Stylesheet
css =
    (stylesheet << namespace prefix)
        []
