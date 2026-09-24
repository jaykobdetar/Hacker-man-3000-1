module Events.Account.Handlers.DbAccountUpdated exposing (Data, handler)

import Decoders.Database exposing (bankAccountEntry)
import Events.Shared exposing (Handler)
import Game.Account.Database.Models exposing (..)
import Json.Decode exposing (decodeValue)


type alias Data =
    ( HackedBankAccountID, HackedBankAccount )


handler : Handler Data msg
handler toMsg =
    decodeValue bankAccountEntry >> Result.map toMsg
