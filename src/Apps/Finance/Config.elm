module Apps.Finance.Config exposing (..)

import Apps.Finance.Messages exposing (..)
import Game.Account.Finances.Models as Finances


type alias Config msg =
    { toMsg : Msg -> msg
    , finances : Finances.Model
    , batchMsg : List msg -> msg
    }
