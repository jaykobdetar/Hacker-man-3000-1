module Game.BackFlix.Requests exposing
    ( LogResponse(..)
    , Response(..)
    , logReceive
    , receive
    )

import Game.BackFlix.Messages exposing (..)


type Response
    = Response


type LogResponse
    = BackFlixResponse


receive : RequestMsg -> Maybe Response
receive response =
    case response of
        _ ->
            Nothing


logReceive : LogRequestMsg -> Maybe LogResponse
logReceive response =
    Nothing
