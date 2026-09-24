module Events.Account.Handlers.BounceRemoved exposing (Data, handler)

import Decoders.Bounces exposing (bounceId)
import Events.Shared exposing (Handler)
import Game.Account.Bounces.Shared exposing (ID)
import Json.Decode exposing (decodeValue)


type alias Data =
    ID


handler : Handler Data msg
handler toMsg =
    decodeValue bounceId >> Result.map toMsg
