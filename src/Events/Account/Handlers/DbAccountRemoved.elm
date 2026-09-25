module Events.Account.Handlers.DbAccountRemoved exposing (Data, handler)

import Decoders.Database exposing (hackedBankAccountId)
import Events.Shared exposing (Handler)
import Game.Account.Database.Models exposing (..)
import Json.Decode exposing (decodeValue)


type alias Data =
    HackedBankAccountID


handler : Handler Data msg
handler toMsg =
    decodeValue hackedBankAccountId >> Result.map toMsg
