module OS.WindowManager.Sidebar.Config exposing (..)

import ContextMenu
import Game.Storyline.Models as Storyline
import Html exposing (Attribute)
import OS.WindowManager.Sidebar.Messages exposing (..)


type alias Config msg =
    { toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    , menuAttr : List (List ( ContextMenu.Item, msg )) -> Attribute msg
    , story : Maybe Storyline.Model
    }
