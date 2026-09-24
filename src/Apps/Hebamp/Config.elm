module Apps.Hebamp.Config exposing (..)

import Apps.Hebamp.Messages exposing (..)
import Game.Meta.Types.Desktop.Apps exposing (Reference)
import Html exposing (Attribute)


type alias Config msg =
    { toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    , reference : Reference
    , draggable : Attribute msg
    , windowMenu : Attribute msg
    , onCloseApp : msg
    }
