module Apps.BackFlix.Config exposing (..)

import Apps.BackFlix.Messages exposing (..)
import Game.BackFlix.Models as BackFlix


type alias Config msg =
    { toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    , logs : BackFlix.Model
    }
