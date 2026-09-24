module Game.BackFlix.Update exposing (update)

import Game.BackFlix.Config exposing (..)
import Game.BackFlix.Messages exposing (..)
import Game.BackFlix.Models exposing (..)
import Utils.React as React exposing (React)


type alias UpdateResponse msg =
    ( Model, React msg )


update : Config msg -> Msg -> Model -> UpdateResponse msg
update _ msg model =
    case msg of
        HandleCreate log ->
            onHandleCreate log model


onHandleCreate : Log -> Model -> UpdateResponse msg
onHandleCreate log model =
    model
        |> insert log
        |> React.update
