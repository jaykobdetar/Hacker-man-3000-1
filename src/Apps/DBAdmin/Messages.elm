module Apps.DBAdmin.Messages exposing (Msg(..))

import Apps.DBAdmin.Models exposing (MainTab(..))
import Game.Servers.Logs.Models exposing (ID)


type Msg
    = GoTab MainTab
    | ToogleExpand MainTab ID
    | UpdateTextFilter MainTab String
    | EnterEditing MainTab ID
    | ApplyEditing MainTab ID
    | LeaveEditing MainTab ID
    | StartDeleting MainTab ID
    | UpdateServersEditingNick ID String
    | UpdateServersEditingNotes ID String
