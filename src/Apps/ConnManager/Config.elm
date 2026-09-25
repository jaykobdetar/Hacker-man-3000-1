module Apps.ConnManager.Config exposing (..)

import Apps.ConnManager.Messages exposing (..)
import Game.Servers.Models as Servers


type alias Config msg =
    { toMsg : Msg -> msg
    , activeServer : Servers.Server
    , batchMsg : List msg -> msg
    }
