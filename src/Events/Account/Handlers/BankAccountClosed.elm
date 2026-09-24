module Events.Account.Handlers.BankAccountClosed exposing (Data, handler)

import Decoders.Finances exposing (accountId)
import Events.Shared exposing (Handler)
import Game.Account.Finances.Models exposing (..)
import Json.Decode exposing (decodeValue)


type alias Data =
    AccountId


handler : Handler Data msg
handler toMsg =
    decodeValue accountId >> Result.map toMsg
