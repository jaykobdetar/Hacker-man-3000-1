module Game.Messages exposing (..)

import Game.Account.Messages as Account
import Game.BackFlix.Messages as BackFlix
import Game.Inventory.Messages as Inventory
import Game.Meta.Messages as Meta
import Game.Servers.Messages as Servers
import Game.Storyline.Messages as Story
import Game.Web.Messages as Web
import Json.Decode exposing (Value)
import Requests.Types exposing (ResponseType)


type Msg
    = AccountMsg Account.Msg
    | ServersMsg Servers.Msg
    | MetaMsg Meta.Msg
    | StoryMsg Story.Msg
    | InventoryMsg Inventory.Msg
    | WebMsg Web.Msg
    | BackFlixMsg BackFlix.Msg
    | Resync
    | ResyncRequest ResponseType
    | HandleJoinedAccount Value
