module Game.Requests.Resync exposing
    ( Data
    , resyncReceive
    , resyncRequest
    )

import Decoders.Game exposing (ServersToJoin)
import Game.Account.Models as Account
import Game.Models exposing (..)
import Json.Decode exposing (Value, decodeValue)
import Requests.Requests as Requests exposing (report)
import Requests.Topics as Topics
import Requests.Types
    exposing
        ( Code(..)
        , FlagsSource
        , ResponseType
        , emptyPayload
        )


type alias Data =
    Result () ( Model, ServersToJoin )


resyncRequest : Account.ID -> FlagsSource a -> Cmd ResponseType
resyncRequest id =
    Requests.request (Topics.accountResync id) emptyPayload


resyncReceive : Model -> ResponseType -> Data
resyncReceive model ( code, json ) =
    case code of
        OkCode ->
            json
                |> decodeValue (Decoders.Game.bootstrap model)
                |> report "Game.Resync" code model
                |> Result.mapError (always ())

        _ ->
            Err ()
