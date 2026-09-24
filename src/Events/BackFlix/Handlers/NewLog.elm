module Events.BackFlix.Handlers.NewLog exposing (..)

import Decoders.BackFlix
import Events.Shared exposing (Handler)
import Game.BackFlix.Models exposing (Log)
import Json.Decode exposing (decodeValue)


type alias Data =
    Log


handler : Handler Data msg
handler toMsg =
    decodeValue Decoders.BackFlix.log >> Result.map toMsg
