module Setup.Pages.Mainframe.Config exposing (Config)

import Core.Flags as Core
import Game.Servers.Shared exposing (CId)
import Setup.Pages.Mainframe.Messages exposing (..)
import Setup.Settings as Settings exposing (Settings)


type alias Config msg =
    { onNext : List Settings -> msg
    , onPrevious : msg
    , toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    , flags : Core.Flags
    , onServerSetName : CId -> String -> msg
    , mainframe : Maybe CId
    }
