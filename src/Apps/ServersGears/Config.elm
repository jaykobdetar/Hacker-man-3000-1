module Apps.ServersGears.Config exposing (..)

import Apps.ServersGears.Messages exposing (..)
import Game.Inventory.Models as Inventory
import Game.Meta.Types.Components.Motherboard as Motherboard exposing (Motherboard)
import Game.Servers.Models as Servers


type alias Config msg =
    { toMsg : Msg -> msg
    , inventory : Inventory.Model
    , activeServer : Servers.Server
    , mobo : Maybe Motherboard
    , batchMsg : List msg -> msg
    , onUpdate : Motherboard -> msg
    }
