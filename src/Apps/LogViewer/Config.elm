module Apps.LogViewer.Config exposing (..)

import Apps.LogViewer.Messages exposing (..)
import ContextMenu
import Game.Servers.Logs.Models as Logs
import Html exposing (Attribute)


type alias Config msg =
    { toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    , logs : Logs.Model
    , menuAttr : ContextMenuAttribute msg
    , onUpdate : Logs.ID -> String -> msg
    , onEncrypt : Logs.ID -> msg
    , onHide : Logs.ID -> msg
    , onDelete : Logs.ID -> msg
    }



-- helpers


type alias ContextMenuItens msg =
    List (List ( ContextMenu.Item, msg ))


type alias ContextMenuAttribute msg =
    ContextMenuItens msg -> Attribute msg
