module Events.Server.Logs.Changed exposing (..)

import Decoders.Logs
import Events.Shared exposing (Handler)
import Json.Decode exposing (decodeValue)


type alias Data =
    Decoders.Logs.Index


handler : Handler Data msg
handler toMsg =
    decodeValue Decoders.Logs.index >> Result.map toMsg
