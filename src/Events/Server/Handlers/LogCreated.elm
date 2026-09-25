module Events.Server.Handlers.LogCreated exposing (..)

import Decoders.Logs
import Events.Shared exposing (Handler)
import Json.Decode exposing (decodeValue)


type alias Data =
    Decoders.Logs.LogWithIndex


handler : Handler Data msg
handler toMsg =
    decodeValue Decoders.Logs.logWithId >> Result.map toMsg
