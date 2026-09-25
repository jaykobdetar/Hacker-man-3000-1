module Apps.LanViewer.View exposing (view)

import Apps.LanViewer.Config exposing (..)
import Apps.LanViewer.Models exposing (..)
import Apps.LanViewer.Resources exposing (..)
import Html exposing (..)
import Html.CssHelpers


{ id, class, classList } =
    Html.CssHelpers.withNamespace prefix


view : Config -> Model -> Html msg
view config model =
    div [] [ text "TODO" ]
