module Apps.LanViewer.Style exposing (..)

import Apps.LanViewer.Resources exposing (..)
import Css exposing (..)
import Css.Namespace exposing (namespace)


css : Stylesheet
css =
    (stylesheet << namespace prefix)
        []
