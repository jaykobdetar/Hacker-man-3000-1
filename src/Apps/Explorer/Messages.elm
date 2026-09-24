module Apps.Explorer.Messages exposing (Msg(..))

import Apps.Explorer.Models exposing (..)
import Game.Servers.Filesystem.Shared as Filesystem
import Game.Servers.Shared exposing (StorageId)


type Msg
    = GoPath Filesystem.Path
    | GoStorage StorageId
    | UpdateEditing EditingStatus
    | EnterRename Filesystem.Id
    | EnterRenameDir Filesystem.Path
    | EnterModal (Maybe ModalAction)
    | ApplyEdit
