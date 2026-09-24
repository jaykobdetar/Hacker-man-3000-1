module Decoders.Bank exposing (accountData)

import Game.Account.Finances.Shared exposing (BankAccountData)
import Json.Decode as Decode
    exposing
        ( Decoder
        , dict
        , field
        , float
        , int
        , string
        )
import Json.Decode.Pipeline exposing (decode, required)


accountData : Decoder BankAccountData
accountData =
    decode BankAccountData
        |> required "balance" int
