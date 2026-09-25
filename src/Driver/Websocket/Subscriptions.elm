module Driver.Websocket.Subscriptions exposing (subscriptions)

import Dict exposing (Dict)
import Driver.Websocket.Models exposing (..)
import Phoenix


subscriptions : Model msg -> Sub msg
subscriptions model =
    model.channels
        |> Dict.values
        |> Phoenix.connect model.socket
