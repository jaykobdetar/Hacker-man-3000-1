module Game.Servers.Tunnels.Update exposing (update)

import Game.Servers.Tunnels.Config exposing (..)
import Game.Servers.Tunnels.Messages exposing (..)
import Game.Servers.Tunnels.Models exposing (..)
import Utils.React as React exposing (React)


type alias UpdateResponse msg =
    ( Model, React msg )


update : Config msg -> Msg -> Model -> UpdateResponse msg
update config msg model =
    ( model, React.none )
