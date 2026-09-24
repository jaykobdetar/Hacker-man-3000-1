module Apps.Bug.Style exposing (..)

import Apps.Bug.Resources exposing (..)
import Css exposing (..)
import Css.Namespace exposing (namespace)


css : Stylesheet
css =
    (stylesheet << namespace prefix)
        []
