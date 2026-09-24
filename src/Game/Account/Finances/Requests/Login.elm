module Game.Account.Finances.Requests.Login exposing
    ( Data
    , Payload
    , loginRequest
    )

import Decoders.Bank exposing (accountData)
import Game.Account.Finances.Models as Finances exposing (AccountNumber)
import Game.Account.Finances.Shared exposing (BankAccountData)
import Game.Account.Models as Account
import Game.Meta.Types.Network as Network
import Json.Decode exposing (Value, decodeValue)
import Json.Encode as Encode
import Requests.Requests as Requests exposing (report)
import Requests.Topics as Topics
import Requests.Types exposing (Code(..), FlagsSource)


type alias Payload =
    { bank : Network.NIP
    , accountNum : AccountNumber
    , password : String
    }


type alias Data =
    Result Error BankAccountData


type Error
    = Invalid
    | Unknown


loginRequest : Payload -> Account.ID -> FlagsSource a -> Cmd Data
loginRequest payload accountId flagsSrc =
    flagsSrc
        |> Requests.request (Topics.bankLogin accountId)
            (encoder payload)
        |> Cmd.map (uncurry <| receiver flagsSrc)



-- internals


encoder : Payload -> Value
encoder { bank, accountNum, password } =
    Encode.object
        [ ( "bank_net", Encode.string (Network.getId bank) )
        , ( "bank_ip", Encode.string (Network.getIp bank) )
        , ( "account", Encode.int accountNum )
        , ( "password", Encode.string password )
        ]


receiver : FlagsSource a -> Code -> Value -> Data
receiver flagsSrc code value =
    case code of
        OkCode ->
            value
                |> decodeValue accountData
                |> report "Finances.Login" code flagsSrc
                |> Result.mapError (always Unknown)

        _ ->
            --TODO: Threat this error properly
            Err Invalid
