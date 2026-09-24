module Events.Server.Handlers.MotherboardUpdated exposing (..)

import Decoders.Hardware
import Events.Shared exposing (Handler)
import Game.Servers.Hardware.Models as Hardware
import Json.Decode exposing (decodeValue)


type alias Data =
    Hardware.Model


handler : Handler Data msg
handler toMsg =
    decodeValue Decoders.Hardware.hardware >> Result.map toMsg
