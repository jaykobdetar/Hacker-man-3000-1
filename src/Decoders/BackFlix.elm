module Decoders.BackFlix exposing (..)

import Game.BackFlix.Models exposing (..)
import Json.Decode as Decode
    exposing
        ( Decoder
        , andThen
        , field
        , float
        , map
        , string
        , succeed
        , value
        )
import Json.Decode.Pipeline exposing (custom, decode, required)


log : Decoder Log
log =
    decode Log
        |> custom type_
        |> required "meta" value
        |> required "timestamp" float
        |> required "type" string


type_ : Decoder Type
type_ =
    andThen decodeType <| field "type" string


channel : Decoder String
channel =
    string
        |> field "channel"
        |> field "data"
        |> field "meta"


decodeChannel : String -> Type
decodeChannel channel =
    case channel of
        "account" ->
            JoinAccount

        "server" ->
            JoinServer

        _ ->
            Join


decodeType : String -> Decoder Type
decodeType typename =
    case typename of
        "event" ->
            succeed Event

        "request" ->
            succeed Request

        "receive" ->
            succeed Receive

        "join" ->
            map decodeChannel channel

        "error" ->
            succeed Error

        _ ->
            succeed Other
