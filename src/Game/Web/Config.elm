module Game.Web.Config exposing (..)

import Core.Flags as Core
import Game.Meta.Types.Desktop.Apps exposing (Requester)
import Game.Servers.Models as Servers
import Game.Servers.Shared exposing (CId)
import Game.Web.Messages exposing (..)
import Json.Decode exposing (Value)


type alias Config msg =
    { toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    , flags : Core.Flags
    , servers : Servers.Model
    , onLogin : CId -> Maybe Value -> msg
    , onJoinedServer : CId -> CId -> msg
    , onJoinFailed : Requester -> msg
    }
