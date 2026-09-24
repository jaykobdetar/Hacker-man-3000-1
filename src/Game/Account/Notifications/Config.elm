module Game.Account.Notifications.Config exposing (..)

import Core.Flags as Core
import Game.Account.Notifications.Messages exposing (..)
import Game.Account.Notifications.Shared exposing (..)
import Time exposing (Time)


type alias Config msg =
    { flags : Core.Flags
    , toMsg : Msg -> msg
    , lastTick : Time
    , onToast : Content -> msg
    }


type alias ActionConfig msg =
    { batchMsg : List msg -> msg
    , openThunderbird : msg
    }
