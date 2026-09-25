module Events.Config exposing (..)

import Events.Account.Config as Account
import Events.BackFlix.Config as BackFlix
import Events.Server.Config as Server


type alias Config msg =
    { forAccount : Account.Config msg
    , forServer : Server.Config msg
    , forBackFlix : BackFlix.Config msg
    }
