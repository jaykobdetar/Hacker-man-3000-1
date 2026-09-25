module Game.Web.Messages exposing (..)

import Game.Meta.Types.Desktop.Apps exposing (Requester)
import Game.Meta.Types.Network as Network
import Game.Servers.Shared as Servers exposing (CId)


type Msg
    = Login Servers.CId Network.NIP Network.IP String Requester
    | JoinedServer Servers.CId
    | HandleJoinServerFailed Servers.CId
