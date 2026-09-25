module Apps.TaskManager.Config exposing (..)

import Apps.TaskManager.Messages exposing (..)
import ContextMenu
import Game.Servers.Processes.Models as Processes
import Game.Servers.Processes.Shared as Processes
import Html exposing (Attribute)
import Time exposing (Time)


type alias Config msg =
    { toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    , processes : Processes.Model
    , lastTick : Time
    , menuAttr : ContextMenuAttribute msg
    , onPause : Processes.ID -> msg
    , onResume : Processes.ID -> msg
    , onRemove : Processes.ID -> msg
    }



-- helpers


type alias ContextMenuItens msg =
    List (List ( ContextMenu.Item, msg ))


type alias ContextMenuAttribute msg =
    ContextMenuItens msg -> Attribute msg
