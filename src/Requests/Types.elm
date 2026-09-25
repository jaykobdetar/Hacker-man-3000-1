module Requests.Types exposing
    ( Code(..)
    , Context
    , Driver(..)
    , FlagsSource
    , ResponseType
    , WebsocketResponse
    , emptyPayload
    , getCode
    )

import Core.Flags as Core
import Json.Decode exposing (Value)
import Json.Encode as Encode


type alias FlagsSource a =
    { a | flags : Core.Flags }


type alias ResponseType =
    ( Code, Value )


type alias WebsocketResponse =
    { data : Value }


type Driver
    = WebsocketDriver
    | HttpDriver


type Code
    = OkCode
    | NotFoundCode
    | BadRequestCode
    | UnknownErrorCode
    | ErrorCode
    | Timeout


type alias Context =
    Maybe String


getCode : Int -> Code
getCode code =
    case code of
        200 ->
            OkCode

        404 ->
            NotFoundCode

        400 ->
            BadRequestCode

        _ ->
            UnknownErrorCode


emptyPayload : Encode.Value
emptyPayload =
    -- empty payload for request
    Encode.object []
