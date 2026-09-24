module Game.Subscriptions exposing (subscriptions)

import Game.Messages exposing (..)
import Game.Meta.Messages as Meta
import Game.Models exposing (..)
import Time exposing (Time, every, second)


subscriptions : Model -> Sub Msg
subscriptions model =
    -- this should be moved to meta
    Sub.map MetaMsg (Time.every second Meta.Tick)
