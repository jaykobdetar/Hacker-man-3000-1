module Events.Server.Handlers.ProcessCompleted exposing (..)

import Events.Shared exposing (Handler)
import Game.Servers.Processes.Shared exposing (..)
import Json.Decode exposing (Decoder, decodeValue, field, string)


type alias Data =
    ID


handler : Handler Data msg
handler toMsg =
    decodeValue decoder >> Result.map toMsg



-- internals


decoder : Decoder Data
decoder =
    field "process_id" string
