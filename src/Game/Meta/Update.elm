module Game.Meta.Update exposing (update)

import Game.Meta.Config exposing (..)
import Game.Meta.Messages exposing (..)
import Game.Meta.Models exposing (..)
import Utils.React as React exposing (React)


type alias UpdateResponse msg =
    ( Model, React msg )


update : Config msg -> Msg -> Model -> UpdateResponse msg
update config msg model =
    case msg of
        Tick time ->
            ( { model | lastTick = time }, React.none )
