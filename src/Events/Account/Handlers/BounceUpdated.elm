module Events.Account.Handlers.BounceUpdated exposing (Data, handler)

import Decoders.Bounces exposing (bounceWithId)
import Events.Shared exposing (Handler)
import Game.Account.Bounces.Models exposing (Bounce)
import Game.Account.Bounces.Shared exposing (ID)
import Json.Decode exposing (decodeValue)


type alias Data =
    ( ID, Bounce )


handler : Handler Data msg
handler toMsg =
    decodeValue bounceWithId >> Result.map toMsg
