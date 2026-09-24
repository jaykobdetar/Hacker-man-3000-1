module Game.Servers.Requests exposing
    ( Response(..)
    , ServerResponse(..)
    , receive
    , serverReceive
    )

import Game.Servers.Messages
    exposing
        ( RequestMsg(..)
        , ServerRequestMsg(..)
        )
import Game.Servers.Requests.Resync as Resync
import Time exposing (Time)


type Response
    = ResyncServer Resync.Response


type ServerResponse
    = ServerResponse


receive : Time -> RequestMsg -> Maybe Response
receive now response =
    case response of
        ResyncRequest maybeServerUid id ( code, data ) ->
            Maybe.map ResyncServer <|
                Resync.receive now maybeServerUid id code data


serverReceive : ServerRequestMsg -> Maybe ServerResponse
serverReceive response =
    case response of
        NoOp ->
            Nothing
