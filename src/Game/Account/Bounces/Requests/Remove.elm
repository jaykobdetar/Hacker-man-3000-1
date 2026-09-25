module Game.Account.Bounces.Requests.Remove exposing (removeRequest)

import Game.Account.Bounces.Shared as Bounces exposing (RemoveError(..))
import Game.Account.Models exposing (..)
import Json.Decode as Decode exposing (Decoder, decodeValue, fail, succeed)
import Json.Encode as Encode exposing (Value)
import Requests.Requests as Requests exposing (report)
import Requests.Topics as Topics
import Requests.Types exposing (Code(..), FlagsSource)
import Utils.Json.Decode exposing (commonError, message)


type alias Data =
    Result RemoveError ()


removeRequest : Bounces.ID -> ID -> FlagsSource a -> Cmd Data
removeRequest bounceId id flagsSrc =
    flagsSrc
        |> Requests.request (Topics.bounceRemove id) (encoder bounceId)
        |> Cmd.map (uncurry <| receiver flagsSrc)



-- internals


encoder : Bounces.ID -> Value
encoder bounceId =
    Encode.object
        [ ( "bounce_id", Encode.string bounceId ) ]


errorToString : RemoveError -> String
errorToString error =
    case error of
        RemoveBadRequest ->
            "Bad Request"

        RemoveUnknown ->
            "Unknown"


errorMessage : Decoder RemoveError
errorMessage =
    message <|
        \str ->
            case str of
                "bad_request" ->
                    succeed RemoveBadRequest

                value ->
                    fail <| commonError "bounce update error message" value


receiver : FlagsSource a -> Code -> Value -> Data
receiver flagsSrc code value =
    case code of
        OkCode ->
            Ok ()

        _ ->
            value
                |> decodeValue errorMessage
                |> report "Bounces.Remove" code flagsSrc
                |> Result.mapError (always RemoveUnknown)
                |> Result.andThen Err
